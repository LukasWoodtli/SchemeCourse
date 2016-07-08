#lang sicp
;; CDR-ing down a list

(define (scale-list scalar lst)
  (if (null? lst)
      '()
      (cons (* (car lst) scalar)
             (scale-list scalar (cdr lst)))))


(scale-list 2 (list 1 2 3))

