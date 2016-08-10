#lang sicp

(#%require racket/include)

(#%require "exercise_2_2.rkt")

(#%require rackunit)


(define (make-rect p1 p2)
  (cons p1 p2))

(define (rect-first-corner rect)
  (car rect))

(define (rect-second-corner rect)
  (cdr rect))


(define (rect-perimeter rect)
  (define (x-dist p1 p2)
    (abs (- (x-point p1) (x-point p2))))
  (define (y-dist p1 p2)
    (abs (- (y-point p1) (y-point p2))))
  (let ((a (rect-first-corner rect))
        (b (rect-second-corner rect)))
        (+ (* 2 (x-dist a b))
           (* 2 (y-dist a b)))))

(define (rect-area rect)
  (let ((p1 (rect-first-corner rect))
        (p2 (rect-second-corner rect)))
    (let ((a (abs (- (x-point p1) (x-point p2))))
          (b (abs (- (y-point p1) (y-point p2)))))
      (* a b))))
    


(check-equal? (rect-perimeter (make-rect (make-point 0 0) (make-point 1 1))) 4)
(check-equal? (rect-perimeter (make-rect (make-point -1 1) (make-point 1 -1))) 8)

(check-equal? (rect-area (make-rect (make-point 0 0) (make-point 1 1))) 1)
(check-equal? (rect-area (make-rect (make-point 1 -1) (make-point -1 1))) 4)

