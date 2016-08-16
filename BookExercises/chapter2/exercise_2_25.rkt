#lang sicp

(#%require rackunit)

(check-equal? (car (cdr (car (cdr (cdr '(1 3 (5 7) 9)))))) 7)

(check-equal? (car (car '((7)))) 7)

(check-equal?
 (car (cdr
       (car (cdr
             (car (cdr
                   (car (cdr
                         (car (cdr
                               (car (cdr
                                     '(1 (2 (3 (4 (5 (6 7))))))
                                     ))
                               ))
                         ))
                   ))
             ))
       ))
 7)
