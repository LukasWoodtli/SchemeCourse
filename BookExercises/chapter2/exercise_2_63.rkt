#lang sicp

(#%require rackunit)

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))


(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))


(define fig2-16-1 '(7 (3 (1 () ()) (5 () ())) (9 () (11 () ())))) 
(define fig2-16-2 '(3 (1 () ()) (7 (5 () ()) (9 () (11 () ()))))) 
(define fig2-16-3 '(5 (3 (1 () ()) ()) (9 (7 () ()) (11 () ())))) 

; a)
(check-equal? (tree->list-1 fig2-16-1) '(1 3 5 7 9 11))
(check-equal? (tree->list-1 fig2-16-2) '(1 3 5 7 9 11))
(check-equal? (tree->list-1 fig2-16-3) '(1 3 5 7 9 11))

(check-equal? (tree->list-2 fig2-16-1) '(1 3 5 7 9 11))
(check-equal? (tree->list-2 fig2-16-2) '(1 3 5 7 9 11))
(check-equal? (tree->list-2 fig2-16-3) '(1 3 5 7 9 11))

; b)
tree->list-1: O(n * log n)
tree->list-2: O(n)