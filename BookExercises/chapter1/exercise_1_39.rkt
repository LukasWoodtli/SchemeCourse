#lang racket

(#%require rackunit)


(define (dec a) (- a 1))

(define (finite-continued-fraction-iter n d k)
  (define (iter n d k accu)
    (if (= k 0)
        accu
        (iter n d (dec k) (/ (n k) (+ accu (d k))))))
  (iter n d k 0))


(define (tan-cf x k)
  (finite-continued-fraction-iter (lambda (i)
                                    (if (= i 1)
                                        x
                                        (- (* x x))))
                                  (lambda (i) (- (* i 2.0) 1))
                                  k))

(check-= (tan-cf 10 100)
         (tan 10)
         0.00001)
