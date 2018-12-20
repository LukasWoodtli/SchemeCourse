#lang sicp

(#%require rackunit)

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance
                     (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((incorrect-num 0))
    (define (dispatch m passwd)
      (cond ((not (eq? passwd password))              
             (lambda (m) "Incorrect password"))
            ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "Unknown request: MAKE-ACCOUNT" m))))
    dispatch))



(define acc (make-account 100 'secret-password))

(check-equal? ((acc 'withdraw 'secret-password) 50) 50)
(check-equal? ((acc 'withdraw 'wrong-password) 50) "Incorrect password")
(check-equal? ((acc 'withdraw 'secret-password) 60) "Insufficient funds")
(check-equal? ((acc 'deposit 'secret-password) 40) 90)
(check-equal? ((acc 'withdraw 'secret-password) 60) 30)

