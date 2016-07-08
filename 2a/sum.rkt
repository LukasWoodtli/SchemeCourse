#lang sicp

(define (SUM TERM A NEXT B)
        (if (> A B)
            0
            (+ (TERM A)
                (SUM TERM
                   (NEXT A)
                   NEXT
                   B))))

(define (++ A) (+ 1 A))

(define (SUM-INT A B)
        (define (ID A) A)
        (SUM ID A ++ B))

;(SUM-INT 3 5)

(define (SUM-SQR A B)
        (define (SQUARE A) (* A A))
        (SUM SQUARE A ++ B))

;(SUM-SQR 4 5)

(define (PI-SUM A B)
        (SUM (lambda (i) (/ 1 (* i (+ 1 2))))
             A
             (lambda (i) (+ i 4))
             B))

;(PI-SUM 2 100)