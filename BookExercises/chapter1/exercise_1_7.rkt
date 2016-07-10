#lang sicp

(#%require rackunit)

(define (sqrt-iter guess oldguess x)
  (if (good-enough? guess oldguess)
      guess
      (sqrt-iter (improve guess x) guess
                 x)))
                 
(define (improve guess x)
        (average guess (/ x guess)))
        
(define (average a b)
        (/ (+ a b) 2))
        
(define (good-enough? guess oldguess)
        (< (abs (- guess oldguess)) (* guess 0.001)))

(define (sqrt x) (sqrt-iter 1.0 2.0 x))

(define (square x) (* x x))

(check-equal? (sqrt 9) 3.000000001396984)
(check-equal? (sqrt (+ 100 37)) 11.704699917758145)
(check-equal? (sqrt (+ (sqrt 2) (sqrt 3))) 1.7737712336472033)
(check-equal? (square (sqrt 1000)) 1000.000369924366)
