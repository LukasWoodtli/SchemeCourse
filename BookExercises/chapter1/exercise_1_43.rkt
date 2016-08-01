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

((repeated square 2) 5)