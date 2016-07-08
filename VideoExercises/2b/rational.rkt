#lang sicp


(define (MAKE-RAT N D)
        (let ((G (gcd N D)))
             (cons (/ N G)
                   (/ D G))))

(define (NUMER RAT) (car RAT))
(define (DENOM RAT) (cdr RAT))

(define (+RAT X Y)
        (MAKE-RAT
         (+ (* (NUMER X)(DENOM Y))
            (* (NUMER Y)(DENOM X)))
         (* (DENOM X)(DENOM Y))))

(define (*RAT X Y)
        (MAKE-RAT
         (* (NUMER X)(NUMER Y))
         (* (DENOM X)(DENOM Y))))

(define A (MAKE-RAT 1 2))
(define B (MAKE-RAT 1 4))

(define ANS (+RAT A B))

(NUMER ANS)
(DENOM ANS)