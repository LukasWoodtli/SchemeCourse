#lang sicp

(#%require rackunit)


;; accumulation/fold-right
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define fold-right accumulate) 


;; fold-left
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))


(check-equal? (fold-right / 1 (list 1 2 3)) (/ 3 2))
(check-equal? (fold-left / 1 (list 1 2 3)) (/ 1 6))
(check-equal? (fold-right list nil (list 1 2 3)) '(1 (2 (3 ()))))
(check-equal? (fold-left list nil (list 1 2 3)) '(((() 1) 2) 3))