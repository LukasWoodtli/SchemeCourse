#lang sicp

(#%require rackunit)

(define (deep-reverse list)
  (define (recurse-if-list item)
    (if (pair? item)
        (deep-reverse item)
        item))
  
  (define (reverse-iter new-list old-list)
    (let ((first (car old-list))
          (rest (cdr old-list)))
    (if (null? rest)
        (cons (recurse-if-list first) new-list)
        (reverse-iter (cons (recurse-if-list first) new-list) rest))))
  (reverse-iter nil list))


(check-equal? (deep-reverse (list 1 4 9 16 25)) '(25 16 9 4 1))

(define x (list (list 1 2) (list 3 4)))
(check-equal? (deep-reverse x) '((4 3) (2 1)))

(define y (list (list (list 1 2 7) (list 3 4)) (list 9 8)))
(check-equal? (deep-reverse y) '((8 9) ((4 3) (7 2 1))))