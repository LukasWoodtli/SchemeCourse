#lang sicp

(#%require rackunit)

(define (make-segment start end)
  (cons start end))
  
(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))
  
(define (y-point point)
  (cdr point))
  
(define (midpoint-segment segment)
  (make-point (/ (+ (x-point (start-segment segment))
                    (x-point (end-segment segment)))
                  2)
              (/ (+ (y-point (start-segment segment))
                    (y-point (end-segment segment)))
                  2)))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))  
  (display ")")
  (newline))  
  
(check-equal? (midpoint-segment (make-segment (make-point 0 0) (make-point 2 0))) (make-point 1 0))
