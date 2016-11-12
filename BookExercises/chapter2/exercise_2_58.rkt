#lang sicp

(#%require rackunit)

 (define (accumulate op initial sequence) 
   (if (null? sequence) 
       initial 
       (op (car sequence) 
           (accumulate op initial (cdr sequence)))))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        ((exponentiation? exp) (make-product (exponend exp) (make-exponentiation (base exp) (- (exponend exp) 1))))
        (else nil))) ;;(raise "unknown expression type -- DERIV" exp))))

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))

(define (addend s) (car s))
(define (augend s)
  (caddr s))

(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))

(define (multiplier p)
  (car p))
(define (multiplicand p)
  (caddr p))


(define (exponentiation? x)
  (and (pair? x) (eq? (cadr x) '**)))
(define (base e)
  (car e))
(define (exponend e)
  (caddr e))
(define (make-exponentiation b e)
  (cond ((=number? e 0) 1)
        ((=number? e 1) b)
        (else (list b '** e))))

(check-equal? (deriv '(x + 3) 'x) '1)
(check-equal? (deriv '(x * y) 'x) 'y)
(check-equal? (deriv '((x * y) * (x + 3)) 'x) '((x * y) +
                                                  (y *
                                                     (x + 3))))
(check-equal? (deriv '(x ** 3) 'x) '(3 * (x ** 2)))
(check-equal? (deriv '((x ** 5) + (x ** 2)) 'x) '((5 * (x ** 4)) + (2 * x)))





