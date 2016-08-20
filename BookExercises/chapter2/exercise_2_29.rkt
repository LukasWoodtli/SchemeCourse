#lang sicp

(#%require rackunit)

; original representation (chaned see d.)
;(define (make-mobile left right)
;  (list left right))

;(define (make-branch length structure)
;  (list length structure))

;; a. selectors
;(define (left-branch mobile)
;  (car mobile))

;(define (right-branch mobile)
;  (car (cdr mobile)))

;(define (branch-length branch)
;  (car branch))

;(define (branch-structure branch)
;  (car (cdr branch)))

;; d. change reprensentation and selectors
(define (make-mobile left right)
  (cons left right))
(define (make-branch length structure)
  (cons length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cdr  mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cdr branch))


;; b. total weight of a mobile
(define (total-weight mobile)
  (define (branch-weight branch)
    (let ((struct (branch-structure branch)))
      (if (pair? struct)
          (total-weight struct)
          struct)))
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

(check-equal? (total-weight (make-mobile (make-branch 2 3) (make-branch 3 4))) 7)

(check-equal? (total-weight (make-mobile (make-branch 2 3)
                                         (make-branch 3 (make-mobile
                                                         (make-branch 1 2)
                                                         (make-branch 2 3))))) 8)

;; c. balanced
(define (balanced? mobile)
  (define (torque w l) (* w l))
  (define (branch-weight branch)
    (let ((struct (branch-structure branch)))
      (if (pair? struct)
          (total-weight struct)
          struct)))
  (define (sub-branch-balanced? branch)
    (let ((sub-mobile (branch-structure branch)))
      (if (pair? sub-mobile)
          (balanced? sub-mobile)
          #t)))
  (let ((l1 (branch-length (left-branch mobile)))
        (w1 (branch-weight (left-branch mobile)))
        (l2 (branch-length (right-branch mobile)))
        (w2 (branch-weight (right-branch mobile))))
    (and (= (torque l1 w1) (torque l2 w2))
         (sub-branch-balanced? (left-branch mobile))
         (sub-branch-balanced? (right-branch mobile)))))

(check-equal? (balanced? (make-mobile (make-branch 2 3) (make-branch 2 3))) #t)

(check-equal? (balanced? (make-mobile (make-branch 3 5) (make-branch 5 3))) #t)

(check-equal? (balanced? (make-mobile (make-branch 2 3) (make-branch 3 4))) #f)

(check-equal? (balanced? (make-mobile (make-branch 2 3)
                                        (make-branch 3 (make-mobile
                                                         (make-branch 1 7)
                                                         (make-branch 2 3))))) #f)

(check-equal? (balanced? (make-mobile (make-branch 5 1)
                                        (make-branch 1 (make-mobile
                                                         (make-branch 3 2)
                                                         (make-branch 2 3))))) #t)

