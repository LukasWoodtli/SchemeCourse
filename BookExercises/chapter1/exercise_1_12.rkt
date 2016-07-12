#lang sicp

(#%require rackunit)

(define (pascal row column)
  (cond ((<= column 0) 1)
        ((<= row 0) 1)
        ((>= column row) 1)
        (else (+ (pascal (dec row) (dec column))
                 (pascal (dec row) column)))))

(check-equal? (pascal 0 0) 1)
(check-equal? (pascal 0 -1) 1)
(check-equal? (pascal -12 1) 1)

(check-equal? (pascal 1 0) 1)
(check-equal? (pascal 1 1) 1)

(check-equal? (pascal 1 2) 1)
(check-equal? (pascal 1 3) 1)

(check-equal? (pascal 2 0) 1)
(check-equal? (pascal 2 1) 2)
(check-equal? (pascal 2 2) 1)
(check-equal? (pascal 2 3) 1)


(check-equal? (pascal 4 3) 4)