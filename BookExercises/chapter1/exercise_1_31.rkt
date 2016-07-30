#lang racket


(#%require rackunit)

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))


(define (inc a) (+ 1 a))
(define (ident a) a)

(define (factorial n)
  (product ident 1 inc n))

(check-equal? (factorial 0) 1)
(check-equal? (factorial 1) 1)
(check-equal? (factorial 2) 2)
(check-equal? (factorial 4) 24)


(define (pi-term n)
  (if (even? n)
      (/ (+ n 2) (+ n 1))
      (/ (+ n 1) (+ n 2))))

(define (pi n)
  (* 4.0 (product pi-term 1 (lambda (n) (+ 1 n)) n)))

(pi 1000)

(define (product-iter term a next b)
  (define (iter term a next b accu)
    (if (> a b)
        accu
        (iter term (next a) next b (* a accu))))
  (iter term a next b 1))

(define (factorial-iter n)
  (product-iter ident 1 inc n))

(check-equal? (factorial-iter 0) 1)
(check-equal? (factorial-iter 1) 1)
(check-equal? (factorial-iter 2) 2)
(check-equal? (factorial-iter 4) 24)
