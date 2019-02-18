#lang sicp

(#%require rackunit)

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        false)))

(define (assoc same-key? key records)
  (cond ((null? records) false)
        ((same-key? key (caar records))
         (car records))
        (else (assoc same-key? key (cdr records)))))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (set-cdr! table
                  (cons (cons key value)
                        (cdr table)))))
  'ok)

(define (make-table same-key?)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable
             (assoc same-key? key-1 (cdr local-table))))
        (if subtable
            (let ((record
                   (assoc same-key? key-2
                          (cdr subtable))))
              (if record (cdr record) false))
            false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable
             (assoc same-key? key-1 (cdr local-table))))
        (if subtable
            (let ((record
                   (assoc same-key? key-2
                          (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr!
                   subtable
                   (cons (cons key-2 value)
                         (cdr subtable)))))
            (set-cdr!
             local-table
             (cons (list key-1
                         (cons key-2 value))
                   (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown poeration: TABLE" m))))
    dispatch))
                  


; Tests

(define mytable (make-table eq?))

((mytable 'insert-proc!) 'a 'a 1)

(check-equal? ((mytable 'lookup-proc) 'a 'a) 1)
(check-equal? ((mytable 'lookup-proc) 'a 'b) false)

((mytable 'insert-proc!) 'a 'b 2)
((mytable 'insert-proc!) 'a 'c 3)

(check-equal? ((mytable 'lookup-proc) 'a 'b) 2)
(check-equal? ((mytable 'lookup-proc) 'a 'c) 3)

((mytable 'insert-proc!) 'a 'a 23)
(check-equal? ((mytable 'lookup-proc) 'a 'a) 23)
