#lang racket

(#%require rackunit)

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (square s)
  (* s s))

(define (divides? a b)
  (= (remainder b a) 0))
  
(check-equal? (smallest-divisor 2) 2)
(check-equal? (smallest-divisor 27) 3)

;; exercise 1.21
(check-equal? (smallest-divisor 199) 199)
(check-equal? (smallest-divisor 1999) 1999)
(check-equal? (smallest-divisor 19999) 7)

(define (prime? n)
  (= n (smallest-divisor n)))

(check-equal? (prime? 29) #t)
(check-equal? (prime? 36) #f)
(check-equal? (prime? 137) #t)