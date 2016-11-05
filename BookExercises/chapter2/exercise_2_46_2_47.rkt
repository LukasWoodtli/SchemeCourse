#lang sicp

(#%require rackunit)

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

;; frames
;(define (make-frame origin edge1 edge2)
;  (list origin edge1 edge2))
;
;(define (frame-origin f)
;  (car f))
;
;(define (frame-edge1 f)
;  (cadr f))
;
;(define (frame-edge2 f)
;  (caddr f))


;; alternative implementation
(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (frame-origin f)
  (car f))

(define (frame-edge1 f)
  (cadr f))

(define (frame-edge2 f)
  (cddr f))


; test
(define f (make-frame 'a 'b 'c))

(check-eq? (frame-origin f) 'a)
(check-eq? (frame-edge1 f) 'b)
(check-eq? (frame-edge2 f) 'c)
