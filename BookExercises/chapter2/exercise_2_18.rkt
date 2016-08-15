#lang sicp

(#%require rackunit)

(define (reverse list)
  (define (reverse-iter new-list old-list)
    (let ((first (car old-list))
          (rest (cdr old-list)))                 
    (if (null? rest)
        (cons first new-list)
        (reverse-iter (cons first new-list) rest))))
  (reverse-iter nil list))


(check-equal? (reverse (list 1 4 9 16 25)) '(25 16 9 4 1))