#lang sicp

(#%require rackunit)


(define (count-pairs x)
  (let ((visited-nodes '()))
    (define (internal-counter x)
      (if (or (not (pair? x)) (memq x visited-nodes))
          0
          (begin (set! visited-nodes (cons x visited-nodes))
                 (+ (internal-counter (car x))
                    (internal-counter (cdr x))
                    1))))
    (internal-counter x)))


; all following examples construct 3 pairs
; but `count-pairs` returns different results

; return 3 pairs
(check-equal? (count-pairs (cons (cons (cons 'a 'b) 'c) 'd)) 3)

; return 4 pairs
(define z (cons 'a 'b))
(check-equal? (count-pairs (cons (cons z z) 'd)) 3)

; return 7 pairs
(define y (cons 'a 'b))
(define x (cons y y))
(check-equal? (count-pairs (cons x x)) 3)

; create infinite list
(define w (cons 'a (cons 'b (cons 'c '()))))
(set-cdr! (cdr (cdr w)) w)
; would get infinite recursion here
(check-equal? (count-pairs w) 3)
