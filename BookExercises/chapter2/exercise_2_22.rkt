#lang SICP

(#%require rackunit)

(define (square x) (* x x))

(define (square-list1 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items nil))

;; not working: add (cons) last element squared to beginning of new list
;; (check-equal? (square-list1 (list 1 2 3 4)) '(1 4 9 16))

(define (square-list2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items nil))

;; not working: creating list of list of list...
;; (check-equal? (square-list2 (list 1 2 3 4)) '(1 4 9 16))
