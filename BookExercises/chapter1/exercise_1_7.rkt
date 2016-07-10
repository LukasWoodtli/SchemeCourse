#lang sicp

(#%require rackunit)

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))
                 
(define (improve guess x)
        (average guess (/ x guess)))
        
(define (average a b)
        (/ (+ a b) 2))
        
(define (good-enough? guess x)
        (< (abs (- (square guess) x)) 0.001))

(define (sqrt x) (sqrt-iter 1.0 x))

(define (square x) (* x x))

(check-equal? (sqrt 9) 3.00009155413138)
(check-equal? (sqrt (+ 100 37)) 11.704699917758145)
(check-equal? (sqrt (+ (sqrt 2) (sqrt 3))) 1.7739279023207892)
(check-equal? (square (sqrt 1000)) 1000.000369924366)
