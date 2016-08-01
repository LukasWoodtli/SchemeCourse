#lang racket

(#%require rackunit)


(define (inc a) (+ a 1))
(define (square x) (* x x))


(define (compose f g)
  (lambda (x)
    (f (g x))))

(check-equal? ((compose square inc) 6) 49)