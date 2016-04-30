;; Newton Square-Root method
;; https://en.wikipedia.org/wiki/Newton's_method#Square_root_of_a_number

(DEFINE (FIXED-POINT F START)
        (DEFINE (ITER OLD NEW)
                (IF (CLOSE-ENOUGH? OLD NEW)
                    NEW
                    (ITER NEW (F NEW))))
        (ITER START (F START)))

(DEFINE (SQRT-NEWTON x)
        (NEWTON (LAMBDA (y) (- X (* Y Y)))
                1))

(DEFINE (NEWTON F GUESS)
        (DEFINE df (DERIV F))
        (FIXED-POINT
          (LAMBDA (x) (- x (/ (f x)(df x))))
          guess))

(DEFINE DERIV
        (LAMBDA (f)
                (LAMBDA (x)
                        (/ (- (f (+ x dx))
                              (f x))
                            dx))))

(DEFINE DX 0.00000001)
(DEFINE (CLOSE-ENOUGH? OLD NEW)
        (< (ABS (- OLD NEW)) 0.00000001))
