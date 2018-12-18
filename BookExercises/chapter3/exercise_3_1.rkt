#lang sicp

(#%require rackunit)


(define (make-accumulator value)
  (lambda (add)
    (set! value (+ value add))
    value))

(define A (make-accumulator 5))

(check-equal? (A 10) 15)
(check-equal? (A 10) 25)
