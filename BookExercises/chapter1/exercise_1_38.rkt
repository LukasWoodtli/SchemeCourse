#lang racket

(#%require rackunit)



(define (dec a) (- a 1))

(define (finite-continued-fraction-iter n d k)
  (define (iter n d k accu)
    (if (= k 0)
        accu
        (iter n d (dec k) (/ (n k) (+ accu (d k))))))
  (iter n d k 0))


(check-= (finite-continued-fraction-iter (lambda (i) 1)
                                (lambda (i)
                                  (if (= (remainder i 3) 2)
                                      (/ (* (+ 1 i) 2) 3.0)
                                      1))
                                1000)
          (- (exp 1) 2) ;; e-2
          0.00000001)