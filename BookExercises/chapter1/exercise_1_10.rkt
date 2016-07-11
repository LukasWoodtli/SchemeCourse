#lang sicp

(#%require rackunit)

(define (ackermann x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (ackermann (- x 1)
                         (ackermann x (- y 1))))))

(check-equal? (ackermann 1 2) 4)
(check-equal? (ackermann 1 10) 1024)
(check-equal? (ackermann 2 4) 65536)
(check-equal? (ackermann 3 3) 65536)