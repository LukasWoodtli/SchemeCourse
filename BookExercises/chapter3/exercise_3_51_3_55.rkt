#lang sicp

(#%require rackunit)


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

;; 3.51
(define x
  (stream-map
   show
   (stream-enumerate-interval 0 10)))
(stream-ref x 5)
(newline)
(stream-ref x 7)

;; 3.52
(define sum 0)
(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq
  (stream-map
   accum
   (stream-enumerate-interval 1 20)))

(define y (stream-filter even? seq))

(define z
  (stream-filter
   (lambda (x)
     (= (remainder x 5) 0)) seq))

(stream-ref y 7)
(display-stream z)


;; 3.53
(define s (cons-stream 1 (add-streams s s)))


;; 3.54
(define (integers-starting-from n)
  (cons-stream
   n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))

(define (mul-stream s1 s2)
  (stream-map * s1 s2))

(define factorials
  (cons-stream 1 (mul-stream
                  factorials (stream-cdr integers))))

;; test
(check-equal? (stream-ref factorials 0) 1) ; 0th element: fac(1)
(check-equal? (stream-ref factorials 1) 2) ; 1th element: fac(2)
(check-equal? (stream-ref factorials 2) 6) ; 2nd element: fac(3)
(check-equal? (stream-ref factorials 3) 24) ; 3rd element: fac(4)


;; 3.55
(define (partial-sums s)
  (cons-stream (stream-car s) (add-streams (partial-sums s) (stream-cdr s))))

;; Test
(check-equal? (stream-ref (partial-sums integers) 0) 1)
(check-equal? (stream-ref (partial-sums integers) 1) 3)
(check-equal? (stream-ref (partial-sums integers) 2) 6)
(check-equal? (stream-ref (partial-sums integers) 3) 10)
(check-equal? (stream-ref (partial-sums integers) 4) 15)
