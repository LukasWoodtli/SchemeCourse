#lang sicp

(#%require rackunit)

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

         
(check-equal? (gcd 206 40) 2)

;; applicative-order:
;; (gcd 206 40)
;; ==> (gcd 40 (remainder 206 40))
;; ==> (gcd 40 6)
;; ==> (gcd 6 (remainder 40 6))
;; ==> (gcd 6 4)
;; ==> (gcd 4 (remainder 6 4))
;; ==> (gcd 4 2)
;; ==> (gcd 2 (remainder 4 2))
;; ==> (gcd 2 0)
;; ==> 2