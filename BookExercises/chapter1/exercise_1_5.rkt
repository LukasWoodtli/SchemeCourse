#lang sicp

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

;; Evaluation order
;; ################

;; Applicative order evaluation (e.g. Scheme)
;; ==========================================
;; All arguments to procedures are evaluated when
;; provided to procedure (when procedure is applied)

;; Normal order evaluation (lazy evaluation)
;; =========================================
;; Delay the evaluation of procedure arguments until
;; they are needed

;; evaluating this expression would never terminate
;; (test 0 (p))

