#lang sicp

(#%require rackunit)

(define (square x) (* x x))

(define (square-tree tree)
  (cond ((null? tree) nil)
        ((pair? tree) (cons (square-tree (car tree))
                            (square-tree (cdr tree))))
        (else (* tree tree))))

(check-equal? (square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
'(1 (4 (9 16) 25) (36 49)))

(define (square-tree-with-map tree)
  (map (lambda (sub-tree)
         (cond ((null? sub-tree) nil)
               ((pair? sub-tree) (square-tree-with-map sub-tree))
               (else (* sub-tree sub-tree))))
       tree))

(check-equal? (square-tree-with-map
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
'(1 (4 (9 16) 25) (36 49)))
