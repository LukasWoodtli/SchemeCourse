#lang racket


(#%require rackunit)


(define (accumulate-iter combiner null-value term a next b accu filter)
  (if (> a b)
      accu
      (accumulate-iter combiner null-value term (next a) next b
                       (if filter
                           (combiner (term a) accu)
                           accu))))


;; todo...

