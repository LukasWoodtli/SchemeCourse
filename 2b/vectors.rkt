(DEFINE (AVERAGE X Y)
        (/
          (+ X Y)
          2))

(DEFINE (MK-VECTOR X Y)
        (CONS X Y))

(DEFINE (X-COR PT)
        (CAR PT))

(DEFINE (Y-COR PT)
        (CDR PT))


(DEFINE (MAKE-SEGMENT P Q)
        (CONS P Q))

(DEFINE (SEG-START S)
        (CAR S))

(DEFINE (SEG-END S)
        (CDR S))


(DEFINE (MIDPOINT S)
        (LET ((a (SEG-START S))
              (b (SEG-END S)))
             (MK-VECTOR
              (AVERAGE (X-COR a) (X-COR b))
              (AVERAGE (Y-COR a) (Y-COR b)))))


(DEFINE A (MK-VECTOR 2 4))
(DEFINE B (MK-VECTOR 4 6))

(DEFINE S (MAKE-SEGMENT A B))

(MIDPOINT S)