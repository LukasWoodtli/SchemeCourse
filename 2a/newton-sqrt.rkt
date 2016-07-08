#lang sicp

;; Newton Square-Root method
;; https://en.wikipedia.org/wiki/Newton's_method#Square_root_of_a_number

(define (FIXED-POINT F START)
        (define (ITER OLD NEW)
                (if (CLOSE-ENOUGH? OLD NEW)
                    NEW
                    (ITER NEW (F NEW))))
        (ITER START (F START)))

(define (SQRT-NEWTON x)
        (NEWTON (lambda (y) (- x (* y y)))
                1))

(define (NEWTON f guess)
        (define df (DERIV f))
        (FIXED-POINT
          (lambda (x) (- x (/ (f x)(df x))))
          guess))

(define DERIV
        (lambda (f)
                (lambda (x)
                        (/ (- (f (+ x dx))
                              (f x))
                            dx))))

(define dx 0.00000001)
(define (CLOSE-ENOUGH? OLD NEW)
        (< (abs (- OLD NEW)) 0.00000001))
