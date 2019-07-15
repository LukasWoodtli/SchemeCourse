#lang racket

(define (ints-from i)
  (stream-cons
   i
   (ints-from (+ 1 i))))
 

(define (divisible? n x)
  (zero? (remainder n x)))


(define (sieve str)
  (stream-cons
   (stream-first str)
   (sieve (stream-filter
           (lambda (x)
             (not (divisible? x (stream-first str))))
           (stream-rest str)))))


(define primes
  (sieve (ints-from 2)))


(stream-ref primes 0)
(stream-ref primes 1)
(stream-ref primes 2)
(stream-ref primes 3)
(stream-ref primes 4)
(stream-ref primes 5)
(stream-ref primes 6)