#lang sicp

(#%require rackunit)

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) 
                      (+ this-coeff (* higher-terms)) )
              0 coefficient-sequence ))
              
(check-equal? (horner-eval 2 (list 1 3 0 5 0 1)) 77)