#lang sicp

(#%require rackunit)


;; accumulation
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap f seq)
  (accumulate append nil (map f seq)))  

(define (enumerate-interval n m)
  (if (< m n)
      nil
      (cons n (enumerate-interval (+ 1 n) m))))

(define (unique-pair n)
  (flatmap (lambda (a)
         (map (lambda (b)
                (list a b))
              (enumerate-interval 1 (- a 1))))
         (enumerate-interval 1 n)))
              

(check-equal? (unique-pair 3) '((2 1)(3 1)(3 2)))




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
          (unique-pair n))))



(check-equal? (prime-sum-pairs 6) '((2 1 3)(3 2 5)(4 1 5)(4 3 7)(5 2 7)(6 1 7)(6 5 11)))
