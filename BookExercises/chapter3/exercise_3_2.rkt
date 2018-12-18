#lang sicp

(#%require rackunit)

(define (make-monitored f)
  (let ((count 0))
    (lambda (arg)
      (if (eq? arg 'how-many-calls)
          count
          (begin (set! count (+ count 1))
                 (f arg))))))


(define s (make-monitored sqrt))

(check-equal? (s 100) 10)
(check-equal? (s 'how-many-calls) 1)
(check-equal? (s 25) 5)
(check-equal? (s 'how-many-calls) 2)
