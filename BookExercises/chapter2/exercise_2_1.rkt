#lang racket


(define (make-rat n d)
  (define (mk-rat-reduced n d) (let ((g (gcd n d)))
       (cons (/ n g) (/ d g))))
  (if (< d 0)
      (mk-rat-reduced (- n) (- d))
      (mk-rat-reduced n  d)))
         


(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom y) (denom x))))
            
(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom y) (numer x))))


(define (equal-rat x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))


(print-rat (make-rat 2 6))
(print-rat (make-rat -3 6))
(print-rat (make-rat 5 -4))
(print-rat (make-rat -15 -25))
