#lang sicp

(#%require rackunit)

(define count 0)

(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
  (write count) (write (newline))
  (set! count (inc count))
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

;; O(log(x)) order of growth

(check-equal? (sine 12.15) -0.39980345741334)