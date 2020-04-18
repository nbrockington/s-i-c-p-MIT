; If f is a numerical function and n is a positive integer, then we
; can form the nth repeated application of f, which is defined to be
; the function whose value at x is f(f(...(f(x))...)). For example, if
; f is the function x x + 1, then the nth repeated application of f is
; the function x -> x + n. If f is the operation of squaring a number,
; then the nth repeated application of f is the function that raises
; its argument to the 2^nth power. Write a procedure that takes as
; inputs a procedure that computes f and a positive integer n and
; returns the procedure that computes the nth repeated application of
; f. Your procedure should be able to be used as follows:
; 
; ((repeated square 2) 5)
; 625
;
; Hint: You may find it convenient to use compose from exercise 1.42.


; Procedure (compose f g) from Exercise 1.42:

(define (compose f g)
   (lambda (x) (f (g x))))



; Procedure (repeated f n):

(define (repeated f n)
   (define (repeated-iter f rep-f i)
      (if (= i n)
          rep-f
          (repeated-iter f (compose f rep-f) (+ 1 i))))
   (repeated-iter f f 1))
