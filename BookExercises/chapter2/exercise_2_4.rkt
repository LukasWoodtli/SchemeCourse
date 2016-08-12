#lang sicp

(#%require rackunit)


(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (x y) x)))

(define (cdr z)
  (z (lambda (x y) y)))

(check-equal? (car (cons 1 2)) 1)
(check-equal? (cdr (cons 1 2)) 2)
