#lang sicp

(#%require rackunit)

(define (even? n)
        (= (remainder n 2) 0))

(define (double a)
  (+ a a))

(define (halve b)
  (floor (/ b 2)))

(define (fast-mult-iter a b)
  (mult-iter a b 0))
  
(define (mult-iter a b accu)
  (cond ((= b 0) accu)
        ((even? b) (mult-iter (double a) (halve b) accu))
        (else (+ a (mult-iter a (dec b) accu)))))

(check-equal? (fast-mult-iter 2 3) 6)
(check-equal? (fast-mult-iter 2 4) 8)
(check-equal? (fast-mult-iter 2 5) 10)
(check-equal? (fast-mult-iter  3 2) 6)
(check-equal? (fast-mult-iter 3 3) 9)
(check-equal? (fast-mult-iter 3 0) 0)
(check-equal? (fast-mult-iter 0 0) 0)
(check-equal? (fast-mult-iter 0 5) 0)
(check-equal? (fast-mult-iter 1 1) 1)
(check-equal? (fast-mult-iter 1 35) 35)
(check-equal? (fast-mult-iter 96 1) 96)
