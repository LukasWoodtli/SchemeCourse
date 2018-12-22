#lang sicp

(#%require rackunit)


(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))


; all following examples construct 3 pairs
; but `count-pairs` returns different results

; return 3 pairs
(check-equal? (count-pairs (cons (cons (cons 'a 'b) 'c) 'd)) 3)

; return 4 pairs
(define z (cons 'a 'b))
(check-equal? (count-pairs (cons (cons z z) 'd)) 4)

; return 7 pairs
(define y (cons 'a 'b))
(define x (cons y y))
(check-equal? (count-pairs (cons x x)) 7)

; create infinite list
(define w (cons 'a (cons 'b (cons 'c '()))))
(set-cdr! (cdr (cdr w)) w)
; would get infinite recursion here
;(count-pairs w)
