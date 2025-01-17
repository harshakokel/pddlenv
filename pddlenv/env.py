import collections
import dataclasses
from typing import AbstractSet, Collection, Generator, Optional, Set, Tuple

import dm_env
import numpy as np

from .base import Action, Predicate, Problem
from .heuristic import Heuristic

StateInitializer = Generator["EnvState", Optional[Problem], None]


class InvalidAction(ValueError):
    pass


@dataclasses.dataclass(frozen=True)
class EnvState:
    __slots__ = ("literals", "problem")
    literals: AbstractSet[Predicate]
    problem: Problem

    def goal_state(self) -> bool:
        return self.problem.goal_satisfied(self.literals)

    def deadend(self) -> bool:
       return not any((a.applicable(self.literals) for a in self.problem.grounded_actions))


@dataclasses.dataclass(frozen=True)
class PDDLDynamics(object):
    __slots__ = ("discount", "use_cost_reward", "heuristic","invalid_action_cost")
    discount: np.ndarray
    use_cost_reward: bool
    heuristic: Optional[Heuristic]
    invalid_action_cost: bool

    def __init__(self,
                 discount: float = 1.,
                 use_cost_reward: bool = True,
                 heuristic: Optional[Heuristic] = None,
                 invalid_action_cost: bool = False):
        super().__setattr__("discount", discount)
        super().__setattr__("use_cost_reward", use_cost_reward)
        super().__setattr__("heuristic", heuristic)
        super().__setattr__("invalid_action_cost", invalid_action_cost)

    def __call__(self, state: EnvState, action: Action) -> dm_env.TimeStep:
        literals = state.literals
        problem = state.problem

        reward = -1. if self.use_cost_reward else 0.
        if action is None:
            # no-op
            next_literals = literals
        else:
            if action.applicable(literals):
                next_literals = action.apply(literals)
            else:
                if not self.invalid_action_cost:
                    raise InvalidAction(f"Preconditions not satisfied.\n\nAction: {action}\n\nState literals: {literals}")
                next_literals = literals
                if self.use_cost_reward:
                    reward -= 2

        goal_reached = problem.goal_satisfied(next_literals)
        if goal_reached:
            reward += 1

        if self.heuristic is not None:
            shaping_reward = self.heuristic(literals, problem)
            if not goal_reached:
                shaping_reward -= self.discount * self.heuristic(next_literals, problem)
            reward += shaping_reward

        next_state = dataclasses.replace(state, literals=next_literals)
        if goal_reached:
            timestep = dm_env.termination(reward, next_state)
        elif next_state.deadend():
            # truncate episode if next state is a dead end
            timestep = dm_env.truncation(reward, next_state, self.discount)
        else:
            timestep = dm_env.transition(reward, next_state, self.discount)
        return timestep

    def sample_transitions(self, state: EnvState
                           ) -> Tuple[Tuple[Action, ...], Tuple[dm_env.TimeStep, ...]]:
        actions = state.problem.valid_actions(state.literals)
        if len(actions) == 0:
            actions = (None,)

        return actions, tuple(self(state, a) for a in actions)


def reachable_states(init_states: Collection[EnvState],
                     dynamics: Optional[PDDLDynamics] = None) -> Set[EnvState]:
    if dynamics is None:
        dynamics = PDDLDynamics()
    stack = collections.deque(init_states)
    seen = set()

    while stack:
        state = stack.pop()
        seen.add(state)

        if not state.goal_state():
            _, timesteps = dynamics.sample_transitions(state)
            _, _, _, next_states = zip(*timesteps)
            stack.extend([s for s in next_states if s not in seen])

    return seen


@dataclasses.dataclass
class PDDLEnv(dm_env.Environment):
    __slots__ = ("dynamics", "state_initializer", "state")
    dynamics: PDDLDynamics
    state_initializer: StateInitializer
    state: Optional[EnvState]

    def __init__(self,
                 state_initializer: StateInitializer,
                 dynamics: Optional[PDDLDynamics] = None,
                 state: Optional[EnvState] = None):
        self.state_initializer = state_initializer
        self.dynamics = dynamics if dynamics is not None else PDDLDynamics()
        self.state = state

    def reset(self):
        self.state = next(self.state_initializer)
        return dm_env.restart(self.state)

    def step(self, action):
        timestep = self.dynamics(self.state, action)
        self.state = timestep.observation
        return timestep

    def observation_spec(self):
        raise NotImplementedError

    def action_spec(self):
        raise NotImplementedError
