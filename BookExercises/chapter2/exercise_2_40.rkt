#lang sicp

(#%require rackunit)


;; accumulation
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap f seq)
  (accumulate append nil (map f seq)))  

(define (enumerate n m)
  (if (< m n)
      nil
      (cons n (enumerate (+ 1 n) m))))

(define (unique-pair n) 

(check-equal? (reverse-b (list 1 2 3)) '(3 2 1))
