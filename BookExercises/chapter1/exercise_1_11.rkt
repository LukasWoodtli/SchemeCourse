#lang sicp

(#%require rackunit)

;; f(n) = n if n<3
;; and f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n>= 3

(define (f-recursive n)
  (if (< n 3)
      n
      (+ (f-recursive (dec n)) (* 2 (f-recursive (- n 2))) (* 3 (f-recursive (- n 3))))))

;; taken from http://community.schemewiki.org/?sicp-ex-1.11
(define (f-iterative n)
  (define (iter a b c count)
    (if (= count 0)
        a
        (iter b c (+ c (* 2 b) (* 3 a)) (- count 1))))
  (iter 0 1 2 n))

(check-equal? (f-recursive 0) 0)
(check-equal? (f-recursive 1) 1)
(check-equal? (f-recursive 2) 2)
(check-equal? (f-recursive 3) 4)
(check-equal? (f-recursive 4) 11)

(check-equal? (f-iterative 0) 0)
(check-equal? (f-iterative 1) 1)
(check-equal? (f-iterative 2) 2)
(check-equal? (f-iterative 3) 4)
(check-equal? (f-iterative 4) 11)