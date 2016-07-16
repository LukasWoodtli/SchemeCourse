#lang sicp

(#%require rackunit)

(define (even? n)
        (= (remainder n 2) 0))

(define (square n)
        (* n n))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))


(check-equal? (fast-expt 1 0) 1)
(check-equal? (fast-expt 1 1) 1)
(check-equal? (fast-expt 1 2) 1)
(check-equal? (fast-expt 2 2) 4)
(check-equal? (fast-expt 3 2) 9)
(check-equal? (fast-expt 2 3) 8)
(check-equal? (fast-expt 5 2) 25)
(check-equal? (fast-expt 11 11) 285311670611)


(define (fast-expt-iter b n)
  (expt-iter b n 1))

(define (expt-iter b n a)
  (if (= n 0)
      a
      (expt-iter b (dec n) (* b a))))

(check-equal? (fast-expt-iter 1 0) 1)
(check-equal? (fast-expt-iter 1 1) 1)
(check-equal? (fast-expt-iter 1 2) 1)
(check-equal? (fast-expt-iter 2 2) 4)
(check-equal? (fast-expt-iter 3 2) 9)
(check-equal? (fast-expt-iter 2 3) 8)
(check-equal? (fast-expt-iter 5 2) 25)
(check-equal? (fast-expt-iter 11 11) 285311670611)


