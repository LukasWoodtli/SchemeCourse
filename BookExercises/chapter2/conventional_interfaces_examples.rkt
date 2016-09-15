#lang sicp

;; Examples from https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2.3
(#%require rackunit)


(define (square x) (* x x))

(define (sum-odd-squares tree)
  (cond ((null? tree) 0)
        ((not (pair? tree))
         (if (odd? tree) (square tree) 0))
        (else (+ (sum-odd-squares (car tree))
                 (sum-odd-squares (cdr tree))))))

(check-equal? (sum-odd-squares '(3 (2 5) ((7 5) 4) 3)) 117)



;; from exercise1.19
(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count) (fib-iter a
                                 b
                                 (+ (* q q) (* p p)) 
                                 (+ (* 2 p q) (* q q))
                                 (/ count 2)))
        (else (fib-iter (+ (* b q)
                           (* a q)
                           (* a p))
                        (+ (* b p)
                           (* a q))
                        p
                        q
                        (- count 1)))))




(define (even-fibs n)
  (define (next k)
    (if (> k n)
        nil
        (let ((f (fib k)))
          (if (even? f)
              (cons f (next (+ k 1)))
              (next (+ k 1))))))
  (next 0))

(check-equal? (even-fibs 3) (list 0 2))


;;;;; Sequence Operations ;;;;;;

;; filtering sequence
(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
         (else (filter predicate (cdr sequence)))))

(check-equal? (filter odd? '(1 2 3 4 5)) '(1 3 5))


;; accumulations
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(check-equal? (accumulate + 0  '(1 2 3 4 5)) 15)
(check-equal? (accumulate * 1  '(1 2 3 4 5)) 120)
(check-equal? (accumulate cons nil '(1 2 3 4 5)) '(1 2 3 4 5))

;; enumerations
(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(check-equal? (enumerate-interval 2 7) '(2 3 4 5 6 7))


(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))
(check-equal? (enumerate-tree '(1 (2 (3 4)) 5)) '( 1 2 3 4 5))


;; sum-of-sqares and even-fibs with sequence operations

(define (sum-odd-squares-with-seq-ops tree)
  (accumulate +
              0
              (map square
                   (filter odd?
                           (enumerate-tree tree)))))

(check-equal? (sum-odd-squares-with-seq-ops '(3 (2 5) ((7 5) 4) 3)) 117)


(define (even-fibs-with-seq-ops n)
  (accumulate cons
              nil
              (filter even?
                      (map fib
                           (enumerate-interval 0 n)))))

(check-equal? (even-fibs-with-seq-ops 3) (list 0 2))


;; list of squares of the first n+1 fibonacci numbers
(define (list-fib-squares n)
  (accumulate cons
              nil
              (map square
                   (map fib
                        (enumerate-interval 0 n)))))

(check-equal? (list-fib-squares 10)
              '(0 1 1 4 9 25 64 169 441 1156 3025))

;; product of odd integers in sequence
(define (product-of-squares-of-odd-elements sequence)
  (accumulate *
              1
              (map square
                   (filter odd? sequence))))

(check-equal? (product-of-squares-of-odd-elements '(1 2 3 4 5)) 225)