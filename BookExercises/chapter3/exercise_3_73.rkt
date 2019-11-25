#lang sicp

(#%require rackunit)

;; This example is not working yet

(define (stream-car stream)
  (car stream))
(define (stream-cdr stream)
  (force (cdr stream)))

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc
                    (map stream-cdr
                         argstreams))))))

(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin
        (proc (stream-car s))
        (stream-for-each proc
                         (stream-cdr s)))))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1)
                                  high))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream)
         the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream
          (stream-car stream)
          (stream-filter
           pred
           (stream-cdr stream))))
        (else (stream-filter
               pred
               (stream-cdr stream)))))

(define (add-streams s1 s2)
  (stream-map + s1 s2))


(define (integers)
  (define (int i)
    (cons-stream i (int (+ 1 i))))
  (int 1))

(define (partial-sums s)
  (cons-stream (stream-car s) (add-streams (partial-sums s) (stream-cdr s))))

(define (scale-stream stream factor)
  (stream-map
   (lambda (x) (* x factor)) stream))

(define (integral integrand initial-value dt)
  (define int
    (cons-stream
     initial-value
     (add-streams (scale-stream integrand dt)
                  int)))
  int)

;; Display
(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))

(define (show x)
  (display-line x)
  (newline)
  x)

;; Exercise 3.73
(define (RC R C dt)
  (lambda (i-stream v0)
    (add-streams (scale-stream (integral i-stream v0 dt) (/ 1 C)) (scale-stream i-stream R))))

(define RC1 (RC 5 1 0.5))

(define i (cons-stream 1 (cons-stream 2 (cons-stream 1 (cons-stream 2 '())))))

; TODO not working: (display-stream (RC1 i 2))

