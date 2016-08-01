#lang racket

(#%require rackunit)


(define (inc a) (+ a 1))

(define (double f)
  (lambda (x) (f (f x))))


(check-equal? ((double inc) 1) 3)

(check-equal? (((double double) inc) 1) 5)

(check-equal? (((double (double double)) inc) 5) 21)