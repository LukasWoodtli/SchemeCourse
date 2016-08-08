#lang sicp

(#%require rackunit)

(define (make-segment start end)
  (cons start end))
  
(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (make-point x y)
  (cons (inexact->exact x) (inexact->exact y)))

(define (x-point point)
  (car point))
  
(define (y-point point)
  (cdr point))
  
(define (midpoint-segment segment)
  (define (average a b) (/ (+  a b) 2))
  (let ((a (start-segment segment))
        (b (end-segment segment)))
       (make-point (average (x-point a)
                            (x-point b))
                   (average (y-point a)
                            (y-point b)))))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))  
  (display ")")
  (newline))  
  
(check-equal? (midpoint-segment (make-segment (make-point 0 0) (make-point 2 0))) (make-point 1.0 0.0))
(check-equal? (midpoint-segment (make-segment (make-point 1 1) (make-point 2 2))) (make-point 1.5 1.5))