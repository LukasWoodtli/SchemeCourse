#lang sicp

(#%require rackunit)

(define (mult a b)
  (if (= a 0)
      0
      (+ b (mult (dec a) b))))

(check-equal? (mult 2 3) 6)
(check-equal? (mult 2 4) 8)
(check-equal? (mult 2 5) 10)
(check-equal? (mult  3 2) 6)
(check-equal? (mult 3 3) 9)
(check-equal? (mult 3 0) 0)
(check-equal? (mult 0 0) 0)
(check-equal? (mult 0 5) 0)

(define (even? n)
        (= (remainder n 2) 0))

(define (double a)
  (+ a a))

(define (half b)
  (/ b 2))

(define (fast-mult a b)
  (cond ((= b 0) 0)
        ((even? b) (double (fast-mult a (half b))))
        (else (+ a (fast-mult a (dec b))))))

(check-equal? (fast-mult 2 3) 6)
(check-equal? (fast-mult 2 4) 8)
(check-equal? (fast-mult 2 5) 10)
(check-equal? (fast-mult  3 2) 6)
(check-equal? (fast-mult 3 3) 9)
(check-equal? (fast-mult 3 0) 0)
(check-equal? (fast-mult 0 0) 0)
(check-equal? (fast-mult 0 5) 0)
(check-equal? (fast-mult 1 1) 1)
(check-equal? (fast-mult 1 35) 35)
(check-equal? (fast-mult 96 1) 96)
