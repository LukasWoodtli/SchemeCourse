#lang sicp


(#%require rackunit)


(define (square-list1 items)
  (if (null? items)
      nil
      (cons (* (car items) (car items)) (square-list1 (cdr items)))))

(check-equal? (square-list1 (list 1 2 3 4))
'(1 4 9 16))

(define (square-list2 items)
 (map (lambda (a) (* a a)) items))

(check-equal? (square-list2 (list 1 2 3 4))
'(1 4 9 16))