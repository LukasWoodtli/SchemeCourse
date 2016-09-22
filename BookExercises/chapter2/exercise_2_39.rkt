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


;; reverse with fold-right
(define (reverse-a sequence)
  (fold-right
   (lambda (x y) (append y (list x))) nil sequence))


(check-equal? (reverse-a (list 1 2 3)) '(3 2 1))
(check-equal? (reverse-a (list 6 1 7)) '(7 1 6))



;; reverse with fold-left
(define (reverse-b sequence)
  (fold-left
   (lambda (x y) (cons y x)) nil sequence))

(check-equal? (reverse-b (list 1 2 3)) '(3 2 1))
(check-equal? (reverse-b (list 6 1 7)) '(7 1 6))

