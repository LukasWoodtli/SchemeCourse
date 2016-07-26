#lang sicp

(#%require rackunit)

;; http://community.schemewiki.org/?sicp-ex-1.19

(define (even? n)
        (= (remainder n 2) 0))


(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count) (fib-iter a
                                 b
                                 (+ (* q q) (* p p)) 
                                 (+ (* 2 p q) (* q q))
                                 (/ count 2)))
        (else (fib-iter (+ (* b q)
                           (* a q)
                           (* a p))
                        (+ (* b p)
                           (* a q))
                        p
                        q
                        (- count 1)))))



(check-equal? (fib 0) 0)
(check-equal? (fib 1) 1)
(check-equal? (fib 2) 1)
(check-equal? (fib 3) 2)
(check-equal? (fib 7) 13)
(check-equal? (fib 10) 55)
(check-equal? (fib 31) 1346269)
(check-equal? (fib 50) 12586269025)
