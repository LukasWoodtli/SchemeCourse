(DEFINE (SUM-INT A B)
        (IF (> A B)
            0
            (+ A
               (SUM-INT (+ A 1) B)
            )
        )
)