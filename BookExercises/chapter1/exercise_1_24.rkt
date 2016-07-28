#lang racket

(#%require rackunit)

(define (square a) (* a a))

; exponential of a number modulo another number
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))


(define (search-for-primes start)
  (cond ((fast-prime? start 10) (display "\nPrime: ") (display start) (display "\n"))
        (else (search-for-primes (+ 1 start)))))


(time (search-for-primes 1000000))
(time (search-for-primes 10000000))
(time (search-for-primes 100000000))