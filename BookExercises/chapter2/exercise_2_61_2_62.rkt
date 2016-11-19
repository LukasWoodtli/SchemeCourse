#lang sicp

(#%require rackunit)

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cond ((or (null? set) (< x (car set))) (cons x set))
        ((= x (car set)) set)
        (else (cons (car set) (adjoin-set x (cdr set))))))


(check-equal? (adjoin-set 2 '(1 3 4 5)) '(1 2 3 4 5))
(check-equal? (adjoin-set 4 '(1 3 4 5)) '(1 3 4 5))


; Union-set computes the union of two sets, which is the set containing
; each element that appears in either argument
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else (adjoin-set (car set1) (union-set (cdr set1) set2)))))
         

(check-equal? (union-set '(1 2 2 3) '(4 5 6)) '(1 2 3 4 5 6))
(check-equal? (union-set '(1 3 5 2 3) '(2 3 4)) '(1 2 3 4 5))