;;  ####
;; ##  ###
;; #     #
;; #.**$@#
;; #   ###
;; ##  #
;;  ####

(define (problem p032-microban-sequential)
  (:domain sokoban-sequential)
  (:objects
    dir-down - direction
    dir-left - direction
    dir-right - direction
    dir-up - direction
    player-01 - player
    pos-1-1 - location
    pos-1-2 - location
    pos-1-3 - location
    pos-1-4 - location
    pos-1-5 - location
    pos-1-6 - location
    pos-1-7 - location
    pos-2-1 - location
    pos-2-2 - location
    pos-2-3 - location
    pos-2-4 - location
    pos-2-5 - location
    pos-2-6 - location
    pos-2-7 - location
    pos-3-1 - location
    pos-3-2 - location
    pos-3-3 - location
    pos-3-4 - location
    pos-3-5 - location
    pos-3-6 - location
    pos-3-7 - location
    pos-4-1 - location
    pos-4-2 - location
    pos-4-3 - location
    pos-4-4 - location
    pos-4-5 - location
    pos-4-6 - location
    pos-4-7 - location
    pos-5-1 - location
    pos-5-2 - location
    pos-5-3 - location
    pos-5-4 - location
    pos-5-5 - location
    pos-5-6 - location
    pos-5-7 - location
    pos-6-1 - location
    pos-6-2 - location
    pos-6-3 - location
    pos-6-4 - location
    pos-6-5 - location
    pos-6-6 - location
    pos-6-7 - location
    pos-7-1 - location
    pos-7-2 - location
    pos-7-3 - location
    pos-7-4 - location
    pos-7-5 - location
    pos-7-6 - location
    pos-7-7 - location
    stone-01 - stone
    stone-02 - stone
    stone-03 - stone
  )
  (:init
    (move-dir pos-3-5 pos-3-4 dir-up)
    (is-nongoal pos-4-1)
    (move-dir pos-2-5 pos-3-5 dir-right)
    (move-dir pos-3-6 pos-4-6 dir-right)
    (move-dir pos-3-2 pos-4-2 dir-right)
    (move-dir pos-6-6 pos-7-6 dir-right)
    (move-dir pos-3-4 pos-3-3 dir-up)
    (move-dir pos-2-3 pos-3-3 dir-right)
    (move-dir pos-4-3 pos-4-4 dir-down)
    (move-dir pos-3-4 pos-3-5 dir-down)
    (clear pos-2-3)
    (is-nongoal pos-2-1)
    (is-nongoal pos-3-6)
    (clear pos-4-6)
    (is-nongoal pos-7-3)
    (is-nongoal pos-3-7)
    (is-goal pos-4-4)
    (move-dir pos-4-4 pos-4-5 dir-down)
    (move-dir pos-3-2 pos-3-3 dir-down)
    (move-dir pos-3-3 pos-3-4 dir-down)
    (move-dir pos-7-7 pos-6-7 dir-left)
    (clear pos-4-3)
    (move-dir pos-4-2 pos-3-2 dir-left)
    (move-dir pos-4-4 pos-5-4 dir-right)
    (is-nongoal pos-6-2)
    (is-nongoal pos-7-7)
    (clear pos-6-1)
    (is-nongoal pos-2-7)
    (move-dir pos-7-1 pos-6-1 dir-left)
    (is-nongoal pos-7-2)
    (clear pos-3-3)
    (is-nongoal pos-2-5)
    (is-nongoal pos-3-5)
    (is-nongoal pos-1-4)
    (is-nongoal pos-4-2)
    (move-dir pos-6-7 pos-7-7 dir-right)
    (is-nongoal pos-1-6)
    (at stone-02 pos-4-4)
    (is-nongoal pos-7-6)
    (is-nongoal pos-3-2)
    (is-goal pos-2-4)
    (move-dir pos-2-4 pos-3-4 dir-right)
    (at stone-01 pos-3-4)
    (clear pos-3-6)
    (move-dir pos-4-3 pos-5-3 dir-right)
    (move-dir pos-6-3 pos-6-4 dir-down)
    (move-dir pos-5-4 pos-6-4 dir-right)
    (move-dir pos-5-3 pos-5-4 dir-down)
    (is-nongoal pos-3-1)
    (move-dir pos-2-4 pos-2-5 dir-down)
    (move-dir pos-6-1 pos-7-1 dir-right)
    (clear pos-2-5)
    (move-dir pos-3-5 pos-3-6 dir-down)
    (is-nongoal pos-2-6)
    (is-nongoal pos-5-3)
    (move-dir pos-2-3 pos-2-4 dir-down)
    (clear pos-4-2)
    (clear pos-6-6)
    (is-nongoal pos-4-5)
    (clear pos-7-7)
    (is-nongoal pos-2-2)
    (move-dir pos-4-5 pos-4-6 dir-down)
    (move-dir pos-6-7 pos-6-6 dir-up)
    (is-nongoal pos-6-5)
    (is-nongoal pos-1-2)
    (is-nongoal pos-6-4)
    (clear pos-7-1)
    (move-dir pos-3-6 pos-3-5 dir-up)
    (move-dir pos-5-4 pos-5-3 dir-up)
    (is-nongoal pos-5-2)
    (is-nongoal pos-1-3)
    (is-nongoal pos-1-7)
    (clear pos-1-7)
    (is-nongoal pos-1-5)
    (is-nongoal pos-5-4)
    (is-nongoal pos-5-1)
    (at-goal stone-01)
    (clear pos-1-1)
    (move-dir pos-7-6 pos-7-7 dir-down)
    (clear pos-6-3)
    (move-dir pos-3-4 pos-4-4 dir-right)
    (move-dir pos-3-3 pos-3-2 dir-up)
    (move-dir pos-7-6 pos-6-6 dir-left)
    (clear pos-2-4)
    (is-nongoal pos-7-5)
    (at player-01 pos-6-4)
    (is-nongoal pos-4-3)
    (move-dir pos-5-3 pos-4-3 dir-left)
    (is-nongoal pos-6-3)
    (move-dir pos-6-4 pos-6-3 dir-up)
    (clear pos-3-5)
    (move-dir pos-4-4 pos-4-3 dir-up)
    (move-dir pos-4-4 pos-3-4 dir-left)
    (is-nongoal pos-5-6)
    (move-dir pos-4-5 pos-4-4 dir-up)
    (is-nongoal pos-5-5)
    (move-dir pos-7-7 pos-7-6 dir-up)
    (move-dir pos-3-5 pos-4-5 dir-right)
    (move-dir pos-3-4 pos-2-4 dir-left)
    (is-nongoal pos-3-3)
    (move-dir pos-2-5 pos-2-4 dir-up)
    (is-nongoal pos-1-1)
    (is-nongoal pos-2-3)
    (move-dir pos-4-5 pos-3-5 dir-left)
    (move-dir pos-6-4 pos-5-4 dir-left)
    (is-nongoal pos-6-6)
    (clear pos-7-6)
    (move-dir pos-6-6 pos-6-7 dir-down)
    (is-goal pos-3-4)
    (is-nongoal pos-7-1)
    (move-dir pos-6-3 pos-5-3 dir-left)
    (is-nongoal pos-4-7)
    (is-nongoal pos-6-1)
    (is-nongoal pos-5-7)
    (clear pos-5-3)
    (clear pos-4-5)
    (move-dir pos-4-3 pos-3-3 dir-left)
    (is-nongoal pos-4-6)
    (is-nongoal pos-6-7)
    (move-dir pos-4-6 pos-3-6 dir-left)
    (move-dir pos-3-3 pos-2-3 dir-left)
    (move-dir pos-3-5 pos-2-5 dir-left)
    (move-dir pos-4-6 pos-4-5 dir-up)
    (move-dir pos-4-2 pos-4-3 dir-down)
    (clear pos-3-2)
    (is-nongoal pos-7-4)
    (move-dir pos-5-4 pos-4-4 dir-left)
    (at stone-03 pos-5-4)
    (clear pos-6-7)
    (move-dir pos-2-4 pos-2-3 dir-up)
    (move-dir pos-5-3 pos-6-3 dir-right)
    (at-goal stone-02)
    (move-dir pos-3-3 pos-4-3 dir-right)
    (move-dir pos-4-3 pos-4-2 dir-up)
  )
  (:goal (and
    (at-goal stone-01)
    (at-goal stone-02)
    (at-goal stone-03)
  ))
)
