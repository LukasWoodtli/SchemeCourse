#lang sicp

(#%require rackunit)

;; accumulation
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

;; map
(define (map p sequence)
  (accumulate (lambda (x y)
               (cons (p x)
                       y)) nil sequence))

(check-equal? (map (lambda (x) (+ 1 x))  '(1 2 3)) '(2 3 4))
(check-equal? (map (lambda (x) (* x x))  '(1 2 3)) '(1 4 9))

;; append
(define (my-append seq1 seq2)
  (accumulate cons seq2 seq1))

(check-equal? (my-append '(1 2 3) '(4 5)) '(1 2 3 4 5))


;; length
(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

(check-equal? (length '(1 2 3)) 3)
(check-equal? (length '(1 2 3 4 5)) 5)