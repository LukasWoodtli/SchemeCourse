#lang sicp

;; 4 Metalinguistic Abstraction

;; 4.1 The Metacircular Evaluator

;; the model has two basic parts:
;; 1. To evaluate a combination (a compound expression other than a special form),
;;    evaluate the subexpressions and then apply the value of the operator subexpression
;;    to the values of the operand subexpressions.
;; 2. To apply a compound procedure to a set of arguments, evaluate the body of the procedure
;;    in a new envi- ronment. To construct this environment, extend the environment part of
;;    the procedure object by a frame in which the formal parameters of the procedure are bound
;;    to the arguments to which the procedure is applied.

;; The job of the evalu- ator is not to specify the primitives of the language, but rather to
;; provide the connective tissue—the means of combination and the means of abstraction—that
;; binds a collection of primitives to form a language. Specifically:
;; - The evaluator enables us to deal with nested expressions.
;; - The evaluator allows us to use variables. [...] We need an evaluator to keep track of
;;   variables and obtain their values before invoking the primitive procedures.
;; - The evaluator allows us to define compound procedures. This involves keeping track of
;;   procedure definitions, knowing how to use these definitions in evaluating expressions,
;;   and providing a mechanism that enables procedures to accept arguments.
;; - The evaluator provides the special forms, which must be evaluated differently from
;;   procedure calls.

;; 4.1.1 The Core of the Evaluator
;; The evaluation process can be described as the interplay between two procedures:
;; `eval` and `apply`.

;; Eval
;; `Eval` takes as arguments an expression and an environment. It classifies the expression
;; and directs its evaluation. `Eval` is structured as a case analysis of the syntactic type
;; of the expression to be evaluated.
;;
;; Each type of expression has a predicate that tests for it and an abstract means for
;; selecting its parts. This *abstract syntax* makes it easy to see how we can change the
;; syntax of the language by using the same evaluator.

;; Primitive expressions
;; - For self-evaluating expressions, such as numbers, eval returns the expression itself.
;; - Eval must look up variables in the environment to find their values.
;; Special forms
;; - For quoted expressions, `eval` returns the expression that was quoted.
;; - An assignment to (or a definition of) a variable must recursively call eval to compute
;;   the new value to be as- sociated with the variable. The environment must be modified to
;;   change (or create) the binding of the variable.
;; - An `if` expression requires special processing of its parts, so as to evaluate the
;;   consequent if the predicate is true, and otherwise to evaluate the alternative.
;; - A `lambda` expression must be transformed into anapplicable procedure by packaging
;;   together the parameters and body specified by the `lambda` expression with the
;;   environment of the evaluation.
;; - A `begin` expression requires evaluating its sequence of expressions in the order in
;;   which they appear.
;; - A case analysis (`cond`) is transformed into a nest of `if` expressions and then evaluated.
;; Combinations
;; - For a procedure application, `eval` must recursively evaluate the operator part and the
;;   operands of the combination. The resulting procedure and arguments are passed to
;;   `apply`, which handles the actual procedure application.

(define apply-in-underlying-scheme apply)

;; eval

(define (eval exp env)
  (cond ((self-evaluating? exp)
         exp)
        ((variable? exp)
         (lookup-variable-value exp env))
        ((quoted? exp)
         (text-of-quotation exp))
        ((assignment? exp)
         (eval-assignment exp env))
        ((definition? exp)
         (eval-definition exp env))
        ((if? exp)
         (eval-if exp env))
        ((lambda? exp)
         (make-procedure
          (lambda-parameters exp)
          (lambda-body exp)
          env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (apply-impl (eval (operator exp) env)
                     (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))


;; Apply
;; `Apply` takes two arguments, a procedure and a list of arguments to which the procedure
;; should be applied. `Apply` classifies procedures into two kinds: It calls
;; `apply-primitive-procedure` to apply primitives; it applies compound procedures by
;; sequentially evaluating the expressions that make up the body of the procedure. The
;; environment for the evaluation of the body of a compound procedure is constructed by
; extending the base environment carried by the procedure to include a frame that binds
; the parameters of the procedure to the arguments to which the procedure is to be applied.

(define (apply-impl procedure arguments)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure procedure arguments))
        ((compound-procedure? procedure)
         (eval-sequence
          (procedure-body procedure)
          (extend-environment
           (procedure-parameters procedure)
           arguments
           (procedure-environment procedure))))
        (else
         (error
          "Unknown procedure type -- APPLY" procedure))))


;; Procedure arguments
;; When `eval` processes a procedure application, it uses `list-of-values` to produce the
;; list of arguments to which the procedure is to be applied.

(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))

;; Conditionals
;; `Eval-if` evaluates the predicate part of an `if` expression in the given environment.
;; If the result is true, `eval-if` evaluates the consequent, otherwise it evaluates the
;; alternative:

(define (eval-if exp env)
  (if (true? (eval (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))


;; Sequences
;; `Eval-sequence` is used by apply to evaluate the sequence of expressions in a procedure
;; body and by `eval` to evaluate the sequence of expressions in a begin expression. It
;; takes as arguments a sequence of expressions and an environment, and evaluates the
;; expressions in the order in which they occur. The value returned is the value of the
;; final expression.

(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        (else (eval (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))


;; Assignments and definitions
;; The following procedure handles assignments to variables. It calls `eval` to find the
;; value to be assigned and transmits the variable and the resulting value to
;; `set-variable-value!` to be installed in the designated environment.

(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
                       (eval (assignment-value exp) env)
                       env)
  'ok)

(define (eval-definition exp env)
  (define-variable! (definition-variable exp)
    (eval (definition-value exp) env)
    env)
  'ok)


;; 4.1.2 Representing Expressions

;;The only self-evaluating items are numbers and strings:

(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))



; Quotations have the form (quote <text-of-quot- ation>)
(define (quoted? exp)
  (tagged-list? exp 'quote))

(define (text-of-quotation exp) (cadr exp))

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

;; Variables are represented by symbols:
(define (variable? exp) (symbol? exp))

;; Assignments have the form (set! <var> <value>):
(define (assignment? exp)
  (tagged-list? exp 'set!))

(define (assignment-variable exp) (cadr exp))
(define (assignment-value exp) (caddr exp))


;; Definitions

(define (definition? exp)
  (tagged-list? exp 'define))
(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))
(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda
       (cdadr exp) ; formal parameters
       (cddr exp)))) ;body

;; Lambda expressions are lists that begin with the symbol lambda:
(define (lambda? exp) (tagged-list? exp 'lambda))

(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))

;; constructor for lambda expressions

(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

;; Conditionals

(define (if? exp) (tagged-list? exp 'if))
(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

;; Begin packages a sequence of expressions into a single expression.

(define (begin? exp) (tagged-list? exp 'begin))
(define (begin-actions exp) (cdr exp))
(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))

;; constructor sequence->exp (for use by cond->if) that transforms a
;; sequence into a single expression

(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))
(define (make-begin seq) (cons 'begin seq))


;; procedure application

(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

;; Derived expressions

(define (cond? exp) (tagged-list? exp 'cond))
(define (cond-clauses exp) (cdr exp))

(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))
(define (cond-predicate clause) (car clause))
(define (cond-actions clause) (cdr clause))
(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false ; no else clause
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last -- COND->IF"
                       clauses))
            (make-if (cond-predicate first)
                     (sequence->exp (cond-actions first))
                     (expand-clauses rest))))))


;; 4.1.3 Evaluator Data Structures

;; Testing of predicates

(define (true? x)
  (not (eq? x false)))
(define (false? x)
  (eq? x false))

;; Representing procedures

(define (make-procedure parameters body env)
  (list 'procedure parameters body env))
(define (compound-procedure? p)
  (tagged-list? p 'procedure))
(define (procedure-parameters p) (cadr p))
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))


;; Operations on Environments

(define (enclosing-environment env) (cdr env))

(define (first-frame env) (car env))
(define the-empty-environment '())

(define (make-frame variables values)
  (cons variables values))
(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (car vals))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))


(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))


(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             (add-binding-to-frame! var val frame))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))


;; 4.1.4 Running the Evaluator as a Program
;; Our evaluator program reduces expressions ultimately to the application
;; of primitive procedures.
;;
;; We thus set up a global environment that associates unique objects with the names
;; of the primitive procedures that can appear in the expressions we will be evaluating.
;; The global environment also includes bindings for the symbols `true` and `false`


(define (setup-environment)
  (let ((initial-env
         (extend-environment (primitive-procedure-names)
                             (primitive-procedure-objects)
                             the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))

(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))

(define (primitive-implementation proc) (cadr proc))

(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        ;;〈more primitives
        ))

(define (primitive-procedure-names)
  (map car
       primitive-procedures))

(define (primitive-procedure-objects)
  (map (lambda (proc) (list 'primitive (cadr proc)))
       primitive-procedures))



(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme
   (primitive-implementation proc) args))

;; For convenience in running the metacircular evaluator, we provide a *driver loop*
;; that models the read-eval-print loop of the underlying Lisp system.

(define input-prompt  ";;; M-Eval input:")
(define output-prompt ";;; M-Eval value:")

;; Uncomment this to get an interactive prompt
;(define (driver-loop)
;  (prompt-for-input input-prompt)
;  (let ((input (read)))
;    (let ((output (eval input the-global-environment)))
;      (announce-output output-prompt)
;      (user-print output)))
;  (driver-loop))

(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))
(define (announce-output string)
  (newline) (display string) (newline))

(define (user-print object)
  (if (compound-procedure? object)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>))
      (display object)))

;; This is part of the interactive
;; interpreter:
;; uncomment it to get an prompt
;(define the-global-environment (setup-environment))
;(driver-loop)


;; Test case

;;; M-Eval input:
;;(define (append x y)
;;  (if (null? x)
;;      y
;;      (cons (car x) (append (cdr x) y))))
;;; M-Eval value:
;; ok

;;; M-Eval input:
;;(append '(a b c) '(d e f))
;;; M-Eval value:
;(a b c d e f)
