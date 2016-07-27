#lang racket

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m)) ;; Applicative order evaluation calculates (expmod base (/ exp 2) m) twice!!!
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))
                