#lang sicp

;; examples of cons car and cdr with only functions (lambdas)

(define (MY-CONS A B)
        (lambda (PICK)
                (cond
                 ((= PICK 1) A)
                 ((= PICK 2) B))))

(define (MY-CAR P)
        (P 1))

(define (MY-CDR P)
        (P 2))

;; Test
(MY-CAR (MY-CONS 2 3))
(MY-CAR (MY-CONS 37 49))

(define P (MY-CONS 23 54))
(MY-CAR P)
(MY-CDR P)