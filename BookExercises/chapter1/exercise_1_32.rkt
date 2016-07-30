#lang racket


(#%require rackunit)

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
         (accumulate combiner null-value term (next a) next b))))


(define (ident a) a)
(define (inc a) (+ 1 a))

(define (factorial n)
  (accumulate * 1 ident 1 inc n))

(check-equal? (factorial 0) 1)
(check-equal? (factorial 1) 1)
(check-equal? (factorial 2) 2)
(check-equal? (factorial 4) 24)


(define (sum a b)
  (accumulate + 0 ident a inc b))

(check-equal? (sum 1 4) 10)
(check-equal? (sum 1 10) 55)
(check-equal? (sum 3 11) 63)


(define (accumulate-iter combiner null-value term a next b accu)
  (if (> a b)
      accu
      (accumulate-iter combiner null-value term (next a) next b (combiner (term a) accu))))

(define (factorial-iter n)
  (accumulate-iter * 1 ident 1 inc n 1))

(check-equal? (factorial-iter 0) 1)
(check-equal? (factorial-iter 1) 1)
(check-equal? (factorial-iter 2) 2)
(check-equal? (factorial-iter 4) 24)

