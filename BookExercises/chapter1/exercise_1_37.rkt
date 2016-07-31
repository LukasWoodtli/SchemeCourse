#lang racket

(#%require rackunit)


;; Recursive
(define (inc a) (+ 1 a))

(define (finite-continued-fraction n d k)
  (define (iter n d k i)
    (define (nom i) (n i))
    (define (denom i) (+ (d i) (iter n d k (inc i))))
    (if (= i k)
        (/ (nom i) 1)
        (/ (nom i) (denom i))))
  (iter n d k 0))


;; Iterative

(define (dec a) (- a 1))

(define (finite-continued-fraction-iter n d k)
  (define (iter n d k accu)
    (if (= k 0)
        accu
        (iter n d (dec k) (/ (n k) (+ accu (d k))))))
  (iter n d k 0))


(let ((recursive (finite-continued-fraction (lambda (i) 1.0)
                           (lambda (i) 1.0)
                           1000))
      (iterative (finite-continued-fraction-iter (lambda (i) 1.0)
                                (lambda (i) 1.0)
                                1000)))
  (check-= recursive iterative 0.00000001))