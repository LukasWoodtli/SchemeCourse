#lang sicp

(#%require rackunit)

(define (dec a) (- a 1))
(define (inc a) (+ a 1))

;; list-ref: get item of list at given position
(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (dec n))))

(define squares (list 1 4 9 16 25))

(check-equal? (list-ref squares 3) 16)

;; length of a list
(define (length lst)
  (if (null? lst)
      0
      (+ 1 (length (cdr lst)))))

(define odds (list 1 3 5 7))

(check-equal? (length odds) 4)

;; length iterative style
(define (length-iter lst)
  (define (iter elements len)
    (if (null? elements)
        len
        (iter (cdr elements) (inc len))))
  (iter lst 0))

(check-equal? (length-iter odds) 4)


;; append
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(check-equal? (append squares odds) '(1 4 9 16 25 1 3 5 7))


(check-equal? (append odds squares) '(1 3 5 7 1 4 9 16 25))


;; scale-list by a factor
(define (scale-list lst factor)
  (if (null? lst)
      nil
      (cons (* factor (car lst)) (scale-list (cdr lst) factor))))

(check-equal? (scale-list (list 1 2 3 4 5) 10) '(10 20 30 40 50))

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items)) (map proc (cdr items)))))
             
(define (scale-list-with-map items factor)
  (map (lambda (x) (* x factor)) items))

(check-equal? (scale-list-with-map (list 1 2 3 4 5) 10) '(10 20 30 40 50))

(define (count-leaves tree)
  (cond ((null? tree) 0)
        ((not (pair? tree)) 1)
        (else (+ (count-leaves (car tree))
                 (count-leaves (cdr tree))))))



(define x (cons (list 1 2) (list 3 4)))

(check-equal? (count-leaves (list x x)) 8)
                               

;; scale a tree by a factor
(define (scale-tree tree factor)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))

(check-equal? (scale-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)) 10) '(10 (20 (30 40) 50) (60 70)))

(define (scale-tree-with-map tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (scale-tree-with-map sub-tree factor)
             (* sub-tree factor)))
       tree))

(check-equal? (scale-tree-with-map (list 1 (list 2 (list 3 4) 5) (list 6 7)) 10) '(10 (20 (30 40) 50) (60 70)))
