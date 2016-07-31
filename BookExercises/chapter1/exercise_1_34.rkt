#lang racket


(#%require rackunit)


(define (f g)
  (g 2))



(define (square x) (* x x))

(check-equal? (f square) 4)

(check-equal? (f (lambda (z) (* z (+ z 1)))) 6)

;; (f f)
;; => (f 2)
;; => (2 2)
;; eror 2 is not applicable