#lang SICP


(define (for-each fun items)
  (cond ((not (null? items))
         (fun (car items))
         (for-each fun (cdr items)))))


(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))
       
