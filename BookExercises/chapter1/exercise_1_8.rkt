#lang sicp

(#%require rackunit)

(define (cube-root-iter guess oldguess x)
  (if (good-enough? guess oldguess)
      guess
      (cube-root-iter (improve guess x) guess
                 x)))
                 
(define (improve guess x)
        (/ (+ (/ x (square guess)) (* 2 guess)) 3))
        

        
(define (good-enough? guess oldguess)
        (< (abs (- guess oldguess)) (* guess 0.001)))

(define (cube-root x) (cube-root-iter 1.0 2.0 x))

(define (square x) (* x x))
(define (qube x) (* x x x))

(check-equal? (cube-root 27) 3.0000005410641766)
(check-equal? (cube-root (qube 4)) 4.000000000076121)

