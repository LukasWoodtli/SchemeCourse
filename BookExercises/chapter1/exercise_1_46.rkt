#lang racket


(define (dec a) (- a 1))
(define (square x) (* x x))

(define (iterative-improvement good-enough improving)
  (lambda (guess)
    (let ((guess-improved (improving guess)))
    (if (good-enough guess guess-improved)
        guess-improved 
        ((iterative-improvement good-enough improving) guess-improved )))))


;; ...