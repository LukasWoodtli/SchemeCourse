



(DEFINE (MAKE-RAT N D)
        (LET ((G (GCD N D)))
             (CONS (/ N G)
                   (/ D G))))

(DEFINE (NUMER RAT) (CAR RAT))
(DEFINE (DENOM RAT) (CDR RAT))

(DEFINE (+RAT X Y)
        (MAKE-RAT
         (+ (* (NUMER x)(DENOM Y))
            (* (NUMER Y)(DENOM X)))
         (* (DENOM X)(DENOM Y))))

(DEFINE (*RAT X Y)
        (MAKE-RAT
         (* (NUMER X)(NUMER Y))
         (* (DENOM X)(DENOM Y))))

(DEFINE A (MAKE-RAT 1 2))
(DEFINE B (MAKE-RAT 1 4))

(DEFINE ANS (+RAT A B))

(NUMER ANS)
(DENOM ANS)