#lang sicp

(#%require rackunit)

;; Needed so that cons-stream is handled as special form
;; see https://wizardbook.wordpress.com/2010/12/20/exercise-3-50/
(define-syntax cons-stream
  (syntax-rules ()
    ((_ A B) (cons A (delay B)))))

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

;; Tests
(check-equal? (stream-ref (integers) 0) 1)
(check-equal? (stream-ref (integers) 1) 2)
(check-equal? (stream-ref (integers) 2) 3)
(check-equal? (stream-ref (integers) 3) 4)
(check-equal? (stream-ref (integers) 4) 5)

(check-equal? (stream-ref (partial-sums (integers)) 0) 1)
(check-equal? (stream-ref (partial-sums (integers)) 1) 3)
(check-equal? (stream-ref (partial-sums (integers)) 2) 6)
(check-equal? (stream-ref (partial-sums (integers)) 3) 10)
(check-equal? (stream-ref (partial-sums (integers)) 4) 15)


;; 3.64
(define (stream-limit s tolerance)
  (if (<= (abs (- (stream-car s) (stream-car (stream-cdr s)))) tolerance)
      (stream-car (stream-cdr s))
      (stream-limit (stream-cdr s) tolerance)))

(define s (cons-stream 1 (cons-stream 5 (cons-stream 6 (cons-stream 10 '())))))

(check-equal? (stream-limit s 1) 6)
(check-equal? (stream-limit s 4) 5)

;; 3.65
(define (ln2)
  (define (ln2-internal i)
    (let* ((temp-part (/ 1 i))
           (part (* temp-part (expt -1 (+ i 1)))))
      (cons-stream part (ln2-internal (+ i 1)))))
  (partial-sums (ln2-internal 1)))

(stream-ref (ln2) 0)
(stream-ref (ln2) 1)
(exact->inexact (stream-ref (ln2) 500))