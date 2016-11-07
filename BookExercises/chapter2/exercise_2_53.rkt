#lang sicp

(#%require rackunit)

(check-equal? (list 'a 'b 'c) '(a b c))
(check-equal? (list (list 'george)) '((george)))
(check-equal? (cdr '((x1 x2) (y1 y2))) '((y1 y2)))

(check-equal? (cadr '((x1 x2) (y1 y2))) '(y1 y2))
(check-equal? (pair? (car '(a short list))) #f)
(check-equal? (memq 'red '((red shoes) (blue socks))) #f)

(check-equal? (memq 'red '(red shoes blue socks)) '(red shoes blue socks))
