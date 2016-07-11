#lang sicp

(#%require rackunit)

;; f(n) = n if n<3
;; and f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n>= 3

(define (f n)
  (if (< n 3)
      n
      (+ (f (dec n)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))
  

(check-equal? (f 0) 0)
(check-equal? (f 1) 1)
(check-equal? (f 2) 2)
(check-equal? (f 3) 4)
(check-equal? (f 4) 11)