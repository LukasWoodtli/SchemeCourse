#lang racket

(define (runtime) (current-milliseconds))

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
  
(define (prime? n)
  (= n (smallest-divisor n)))
;
;(define (timed-prime-test n)
;  (newline)
;  (display n)
;  (start-prime-test n (runtime)))
;
;(define (start-prime-test n start-time)
;  (cond ((prime? n)
;      (report-prime (- (runtime) start-time)))
;      ))
;
;(define (report-prime elapsed-time)
;  (newline)
;  (display " *** ")
;  (newline)
;  (display elapsed-time))


(define (search-for-primes start)
  (cond ((prime? start) (display "\nPrime: ") (display start) (display "\n"))
        (else (search-for-primes (+ 1 start)))))


(time (search-for-primes 1000000))
(time (search-for-primes 10000000000))
(time (search-for-primes 1000000000000000))
