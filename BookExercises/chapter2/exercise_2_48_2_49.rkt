#lang sicp

(#%require rackunit)

;(#%require sicp-pict)

(define (make-vect x y)
  (cons x y))

(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cdr v))

(define (add-vect a b)
  (make-vect (+ (xcor-vect a)(xcor-vect b))
             (+ (ycor-vect a)(ycor-vect b))))

(define (sub-vect a b)
  (make-vect (- (xcor-vect a)(xcor-vect b))
             (- (ycor-vect a)(ycor-vect b))))


(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (frame-origin f)
  (car f))

(define (frame-edge1 f)
  (cadr f))

(define (frame-edge2 f)
  (cddr f))

; Exercise 2.48
(define (make-segment start end)
  (cons start end))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

; Exercise 2.49
;
;(define tl (make-vect 0 1))
;(define tr (make-vect 1 1))
;(define bl (make-vect 0 0))
;(define br (make-vect 1 0))
;; a)
;(paint (segments->painter (list (make-segment bl tl)
;                                (make-segment tl tr)
;                                (make-segment tr br)
;                                (make-segment br bl))))
;
;
;; b)
;(paint (segments->painter (list (make-segment bl tr)
;                                (make-segment br tl))))
;
;
;; c)
;(define t (make-vect 0.5 1))
;(define r (make-vect 1 0.5))
;(define b (make-vect 0.5 0))
;(define l (make-vect 0 0.5))
;(paint (segments->painter (list (make-segment t r)
;                                (make-segment r b)
;                                (make-segment b l)
;                                (make-segment l t))))
;
