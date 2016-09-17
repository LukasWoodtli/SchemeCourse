#lang sicp

(#%require rackunit)


;; accumulation
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (firsts-of-sublist lst)
  (map car lst))

(define (rests-of-sublist lst)
  (map cdr lst))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (firsts-of-sublist seqs))
            (accumulate-n op init (rests-of-sublist seqs)))))

(define s '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))

(check-equal? (accumulate-n + 0 s) '(22 26 30))
