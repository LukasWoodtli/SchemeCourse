#lang sicp

(#%require rackunit)


;; accumulation
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

;; accumulate-n
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))


(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product x v)) m))
(define (transpose mat)
  (accumulate-n cons nil mat))
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x) (matrix-*-vector cols x))  m)))


(check-equal? (dot-product '(-6 8)'(5 12)) 66)
(check-equal? (matrix-*-vector '((3 2 1) (1 0 2)) '(1 0 4)) '(7 9))
(check-equal? (transpose '((1 2) (3 4) (5 6))) '((1 3 5) (2 4 6)))
(check-equal? (matrix-*-matrix '((3 2 1) (1 0 2)) '((1 2) (0 1) (4 0))) '((7 8)(9 2)))

