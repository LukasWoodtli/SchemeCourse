#lang sicp

(#%require rackunit)

; pure functional
(define (append x y)
  (if (null? x)
      y
      (cons (car x) (append (cdr x) y))))


; mutator variant
(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))


;; tests

(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))

(check-equal? z (list 'a 'b 'c 'd))
(check-equal? (cdr x) (list 'b))

(define w (append! x y))

(check-equal? w (list 'a 'b 'c 'd))
(check-equal? (cdr x) (list 'b 'c 'd))