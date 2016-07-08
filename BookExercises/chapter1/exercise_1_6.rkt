#lang sicp

;; using this implementation of if we get an endless loop (duw to evaluation strategy)
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))



(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

(define (square x) (* x x)) 

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))
  
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

;; calling sqrt-iter gives an endless loop
;; (sqrt-iter 1 2)