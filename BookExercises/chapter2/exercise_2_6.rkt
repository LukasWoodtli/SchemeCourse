#lang sicp

(#%require rackunit)

(define zero (lambda (f) (lambda (x) x)))

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;; taken from: http://community.schemewiki.org/?sicp-ex-2.6
(define (church-to-int cn) 
   ((cn (lambda (n) (+ n 1))) 0)) 

(check-equal? (church-to-int zero) 0)
(check-equal? (church-to-int (add-1 zero)) 1)
(check-equal? (church-to-int (add-1 (add-1 zero))) 2)

(check-equal? (church-to-int one) 1)
(check-equal? (church-to-int two) 2)