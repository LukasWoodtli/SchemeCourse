#lang sicp

(#%require rackunit)

(define (last-pair lst)
  (let ((rest (cdr lst)))
    (if (null? rest)
        lst
        (last-pair rest))))
    

(check-equal? (last-pair (list 23 72 149 34)) '(34))