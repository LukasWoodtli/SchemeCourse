#lang sicp

(#%require rackunit)

(define (print-a-b a b)
 (write a)  (write (newline)) (write b) (write (newline))  (write (newline)))

(define (add-a a b)
  ;(print-a-b a b)
  (if (= a 0)
      b
      (inc (add-a (dec a) b))))


(define (add-b a b)
  ;(print-a-b a b)
  (if (= a 0)
      b
      (add-b (dec a) (inc b))))


(check-equal? (add-a 2 3) 5)
(check-equal? (add-b 2 3) 5)
