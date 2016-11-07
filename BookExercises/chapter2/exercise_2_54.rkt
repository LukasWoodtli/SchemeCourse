#lang sicp

(#%require rackunit)


(define (equal? a b)
  (cond ((and (pair? a) (pair? b)) (and (eq? (car a) (car b)) (equal? (cdr a) (cdr b))))
        (else (eq? a b))))


(check-eq? (equal? '(this is a list) '(this is a list)) #t)

(check-eq? (equal? '(this is a list) '(this (is a) list)) #f)

