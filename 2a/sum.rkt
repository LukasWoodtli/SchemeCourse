
(DEFINE (SUM TERM A NEXT B)
        (IF (> A B)
            0
            (+ (TERM A)
                (SUM TERM
                   (NEXT A)
                   NEXT
                   B))))

(DEFINE (++ A) (+ 1 A))

(DEFINE (SUM-INT A B)
        (DEFINE (ID A) A)
        (SUM ID A ++ B))

;(SUM-INT 3 5)

(DEFINE (SUM-SQR A B)
        (DEFINE (SQUARE A) (* A A))
        (SUM SQUARE A ++ B))

;(SUM-SQR 4 5)

(DEFINE (PI-SUM A B)
        (SUM (LAMBDA (i) (/ 1 (* i (+ 1 2))))
             A
             (LAMBDA (i) (+ i 4))
             B))

;(PI-SUM 2 100)