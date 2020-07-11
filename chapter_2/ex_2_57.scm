; Extend the differentiation program to han- dle sums and products of
; arbitrary numbers of (two or more) terms. Then the last example above
; could be expressed as
;
; (deriv '(* x y (+ x 3)) 'x) 203
; 
; Try to do this by changing only the representation for sums and
; products, without changing the deriv procedure at all. For example,
; the addend of a sum would be the first term, and the augend would be
; the sum of the rest of the terms.

; Changing the representations for sums and products:

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s) 
  (if (= 1 (length (cddr s)))
      (caddr s)
      (cons '+ (cddr s))))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
	((sum? a2) (append (list '+ a1) (cdr a2)))
        (else (list '+ a1 a2))))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p) 
  (if (= 1 (length (cddr p)))
      (caddr p)
      (cons '* (cddr p))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
	((product? m2) (append (list '* m1) (cdr m2)))
        (else (list '* m1 m2))))


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
        ((exponentiation? exp)
          (make-product (make-product (exponent exp) 
				      (make-exponentiation (base exp)
							   (- (exponent exp) 1)))
			(deriv (base exp) var)))
        (else
         (error "unknown expression type -- DERIV" exp))))


(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (exponentiation? x)
    (and (pair? x) (eq? (car x) '**)))

(define (base e) (cadr e))

(define (exponent e) (caddr e))

(define (make-exponentiation e1 e2)
    (cond ((=number? e2 0) 1)
	          ((=number? e2 1) e1)
		          (else (list '** e1 e2))))

