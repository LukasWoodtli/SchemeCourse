#lang racket


(#%require rackunit)


(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))


(define (inc a) (+ 1 a))

(define (simpson f a b n)
  (define h (/ (- b a) n))
  (define (yk k) (f (+ a (* k h))))
  (define (simpson-term k)
    (* (cond ((or (= k 0) (= k n)) 1)
             ((even? k) 2)
             (else 4))
       (yk k)))
  (* (/ h 3)
     (sum simpson-term 0 inc n)))


(define (cube a) (* a a a))

(check-equal? (simpson cube 0 1 10000) (/ 1 4))
