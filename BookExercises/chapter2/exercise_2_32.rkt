#lang sicp

(#%require rackunit)

(define (square x) (* x x))


(define (subset s)
  (if (null? s)
      (list nil)
      (let ((rest (subset (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x)) rest)))))

(check-equal? (subset '(1 2 3)) '(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)))
