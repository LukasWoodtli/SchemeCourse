#lang sicp

(#%require rackunit)

(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))


(define
  v (list 'a 'b 'c 'd))


(define w (mystery v))

; reverts order of list
(check-equal? w (list 'd 'c 'b 'a))
