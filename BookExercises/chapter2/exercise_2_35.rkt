#lang sicp

(#%require rackunit)


;; accumulation
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (count-leaves t)
  (accumulate +
              0
              (map
               (lambda (i)
                 (if (pair? i)
                     (count-leaves i)
                     1))
               t)))


(define x (cons (list 1 2) (list 3 4)))

(check-equal? (count-leaves (list x x)) 8)
(check-equal? (count-leaves (list x x x)) 12)
(check-equal? (count-leaves (list x x x x)) 16)
