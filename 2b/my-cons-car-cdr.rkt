;; examples of cons car and cdr with only functions (lambdas)

(DEFINE (MY-CONS A B)
        (LAMBDA (PICK)
                (COND
                 ((= PICK 1) A)
                 ((= PICK 2) B))))

(DEFINE (MY-CAR P)
        (P 1))

(DEFINE (MY-CDR P)
        (P 2))

;; Test
(MY-CAR (MY-CONS 2 3))
(MY-CAR (MY-CONS 37 49))

(DEFINE P (MY-CONS 23 54))
(MY-CAR P)
(MY-CDR P)