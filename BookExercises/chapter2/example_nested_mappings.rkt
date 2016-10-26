#lang sicp

(#%require rackunit)

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-interval a b)
  (if (> a b)
      nil
      (cons a (enumerate-interval (+ 1 a) b))))

(check-equal? (enumerate-interval 1 7) '(1 2 3 4 5 6 7))


(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (square s)
  (* s s))

(define (divides? a b)
  (= (remainder b a) 0))
  
(define (prime? n)
  (= n (smallest-divisor n)))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))
  
(define (prime-sum? p)
  (prime? (+ (car p) (cadr p))))

(define (prime-sum-pairs n)
  (map (lambda (p) (list (car p) (cadr p) (+ (car p) (cadr p))))
       (filter prime-sum?
          (accumulate append nil (map (lambda (i)
                                (map (lambda (j) (list i j))
                                     (enumerate-interval 1 (- i 1))))
                                (enumerate-interval 1 n))))))



(check-equal? (prime-sum-pairs 6) '((2 1 3)(3 2 5)(4 1 5)(4 3 7)(5 2 7)(6 1 7)(6 5 11)))
