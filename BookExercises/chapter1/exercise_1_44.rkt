#lang racket

(#%require rackunit)

(define (dec a) (- a 1))
(define (square x) (* x x))



(define (compose f g)
  (lambda (x)
    (f (g x))))


(define (repeated f n)
  (if (= 1 n)
      f
      (repeated (compose f f) (dec n))))

(define dx 0.00001)

(define (average a b c) (/ (+ a b c) 3))

(define (smooth f)
  (lambda (x)
    (average
     (f (- x dx))
     (f x)
     (f (+ x dx)))))


(define (n-fold-smooth n)
  (repeated smooth n))

((smooth square) 3)

(((n-fold-smooth 7) square) 3)



