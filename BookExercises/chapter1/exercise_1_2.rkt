#lang sicp

(#%require rackunit)


(define exercise_1_2_expression
  (/ (+ 5
        4
        (- 2(- 3 (+ 6 (/ 4 5)))))
     (* 3
        (- 6 2)
        (- 2 7)))
)

(check-equal? (/ -37 150) exercise_1_2_expression)