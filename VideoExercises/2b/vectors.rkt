#lang sicp

(define (AVERAGE X Y)
        (/
          (+ X Y)
          2))

(define (MK-VECTOR X Y)
        (cons X Y))

(define (X-COR PT)
        (car PT))

(define (Y-COR PT)
        (cdr PT))


(define (MAKE-SEGMENT P Q)
        (cons P Q))

(define (SEG-START S)
        (car S))

(define (SEG-END S)
        (cdr S))


(define (MIDPOINT S)
        (let ((a (SEG-START S))
              (b (SEG-END S)))
             (MK-VECTOR
              (AVERAGE (X-COR a) (X-COR b))
              (AVERAGE (Y-COR a) (Y-COR b)))))


(define A (MK-VECTOR 2 4))
(define B (MK-VECTOR 4 6))

(define S (MAKE-SEGMENT A B))

(MIDPOINT S)