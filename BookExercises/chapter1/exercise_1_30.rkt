#lang sicp

(#%require rackunit)

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ a result))))
  (iter a 0))



(define (inc a) (+ 1 a))
(define (ident a) a)

(check-equal? (sum ident 1 inc 10) 55)
(check-equal? (sum ident 1 inc 100) 5050)