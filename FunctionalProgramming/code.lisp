; Usage: mit-scheme < code.lisp

(define (abs x)
  (cond ((< x 0) (- x))
        (else x)))


(define (abst x)
  (if (< x 0)
      (- x)
      x))

(define (sum a b) (+ a b))

(sum 1 2)

(define (sumt x) (sum x))


 (define (curry2 f)
     (lambda (x)
       (lambda (y)
         (f x y))))
(define a (curry2 +))
(define a2 (a 2))
(a2 3)
(a2 5)
(a2 7)

; Map
(define (mapx f arr)
  (if (null? arr)
      '()
      (cons (f (car arr)) (mapx f (cdr arr)))))

(mapx a2 (cons 2 (cons 3 '())))
(mapx a2 (cons 2 '()))

; Reduce

(define (reducex initial f arr)
  (if (null? arr)
      initial
      (reducex (f initial (car arr)) f (cdr arr))))

(define (a3 ini val) (+ ini val))
(reducex 0 a3 (cons 2 (cons 3 '())))
(reducex 10 a3 (cons 2 (cons 3 '())))

; Pipeline
