#lang sicp

(#%require rackunit)

;; Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers. 
(define (sum-sq-larg a b c)
  (if (= a (larger a b))
          (sum-square a (larger b c))
          (sum-square b (larger a c))
))


(define (larger a b) (if (> a b) a b))

(define (sum-square a b) (+ (* a a) (* b b))) 


(check-equal? (sum-sq-larg 1 2 3) 13)
(check-equal? (sum-sq-larg 1 3 4) 25)
(check-equal? (sum-sq-larg 4 1 3) 25)
(check-equal? (sum-sq-larg 3 4 1) 25)

(check-equal? (sum-sq-larg 3 4 5) 41)
(check-equal? (sum-sq-larg 3 5 4) 41)
(check-equal? (sum-sq-larg 5 3 4) 41)
(check-equal? (sum-sq-larg 5 4 3) 41)
(check-equal? (sum-sq-larg 4 3 5) 41)
(check-equal? (sum-sq-larg 4 5 3) 41)
  
(check-equal? (sum-sq-larg -1 -2 -3) 5)
(check-equal? (sum-sq-larg -3 -2 -1) 5)
  
(check-equal? (sum-sq-larg 0 0 -1) 0)
(check-equal? (sum-sq-larg 1 0 -1) 1)
  
(check-equal? (sum-sq-larg 3 3 5) 34)
(check-equal? (sum-sq-larg 3 5 5) 50)