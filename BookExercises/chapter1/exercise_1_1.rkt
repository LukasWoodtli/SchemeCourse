#lang sicp

(define (assert-equal a b) (eqv? a b))

(assert-equal 10 10)

(assert-equal (+ 5 3 4) 12)




(assert-equal (- 9 1) 8)
(assert-equal (/ 6 2) 3)
(assert-equal (+ (* 2 4) (- 4 6)) 6)


(define a 3)
(define b (+ a 1))

(assert-equal (+ a b (* a b)) 19)
(assert-equal (= a b) #f)

(assert-equal (if (and (> b a) (< b (* a b)))
    b
    a) 4)

(assert-equal (cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
              16)

(assert-equal (+ 2 (if (> b a) b a)) 6)

(assert-equal (* (cond ((> a b) a)
                       ((< a b) b)
                       (else -1))
                 (+ a 1))
              16)