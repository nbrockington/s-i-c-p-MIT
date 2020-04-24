; Consider the problem of representing line segments in a plane. Each
; segment is represented as a pair of points: a starting point and an
; ending point. Define a constructor make-segment and selectors
; start-segment and end-segment that define the representation of
; segments in terms of points. Furthermore, a point can be represented
; as a pair of numbers: the x coordinate and the y
; coordinate. Accordingly, specify a constructor make-point and
; selectors x-point and y-point that define this
; representation. Finally, using your selectors and constructors,
; define a procedure midpoint-segment that takes a line segment as
; argument and returns its midpoint (the point whose coordinates are
; the average of the coordinates of the endpoints). To try your
; procedures, you'll need a way to print points:


; Procedure to print points, from book:

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))


; Defining constructor (make-segment):

(define (make-segment start-segment end-segment)
   (cons start-segment end-segment))


; Defining selectors (start-segment) and (end-segment):

(define (start-segment segment)
   (car segment))

(define (end-segment segment)
  (cdr segment))


; Defining constructor (make-point):

(define (make-point x-point y-point)
   (cons x-point y-point))


; Defining selectors (x-point) and (y-point):

(define (x-point point)
   (car point))

(define (y-point point)
   (cdr point))


; Defining procedure (midpoint-segment):

(define (midpoint-segment segment)
   (make-point (average (x-point (start-segment segment))
                        (x-point (end-segment segment)))
               (average (y-point (start-segment segment))
                        (y-point (end-segment segment)))))


(define (average a b)
   (/ (+ a b) 2.0))