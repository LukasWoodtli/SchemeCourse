#lang sicp

(#%require rackunit)

(define (same-parity . lst)
  (let ((parity  (remainder (car lst) 2)))
    (define (iter lst-old lst-new)
      (cond
        ((null? lst-old)
         lst-new)
        ((= (remainder (car lst-old) 2) parity)
         (iter (cdr lst-old) (append lst-new (list (car lst-old)))))
        (else (iter (cdr lst-old) lst-new))))
    (iter lst '())))




(check-equal? (same-parity 1 2 3 4 5 6 7)
'(1 3 5 7))

(check-equal? (same-parity 2 3 4 5 6 7)
'(2 4 6))

