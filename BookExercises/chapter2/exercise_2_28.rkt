#lang sicp

(#%require rackunit)

(define (fringe lst)
  (define (iter old-lst new-lst)
    (cond ((null? old-lst) new-lst)
          ((pair? (car old-lst)) (iter (cdr old-lst) (append new-lst (fringe (car old-lst)))))
          (else (iter (cdr old-lst) (append new-lst (list (car old-lst)))))))
  (iter lst nil))
  
  
(check-equal? (fringe (list 1 4 9 16 25)) '(1 4 9 16 25))

(define x (list (list 1 2) (list 3 4)))
(check-equal? (fringe x) '(1 2 3 4))

(define y (list (list (list 1 2 7) (list 3 4)) (list 9 8)))
(check-equal? (fringe y) '(1 2 7 3 4 9 8))
