#lang sicp

(#%require rackunit)

(define (sqrt-iter guess x)
  (if (good-enough? guess)
      guess
      (sqrt-iter (improve guess x)
                 x)))
                 
(define (improve guess x)
        (average guess x))
        
(define (average a b)
        (/ (+ a b) 2))
        
(define (good-enough? guess x)
        (< (abs (- (* guess guess) x)) 0.001))

(define (sqrt x) (sqrt-iter 1.0 x))


(check-equal? (sqrt 9) 3.00009155413138)
