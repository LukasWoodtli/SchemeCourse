#lang sicp

(define (SUM-INT A B)
        (if (> A B)
            0
            (+ A
               (SUM-INT (+ A 1) B)
            )
        )
)