; Usage: mit-scheme < code.lisp

(define (abs x)
  (cond ((< x 0)
         (- x))
        (else x)
  ))


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

(define (add2 x) (+ x 2))
(mapx add2 (cons 2 '()))
(mapx add2 (cons 2 (cons 3 '())))

; Reduce

(define (reducex initial f arr)
  (if (null? arr)
      initial
      (reducex (f initial (car arr)) f (cdr arr))))

(define (a3 ini val) (+ ini val))
(reducex 0 a3 (cons 2 (cons 3 '())))
(reducex 10 a3 (cons 2 (cons 3 '())))
(reducex 0 - '(1 2 3)) ; -6

; Filter

(define (filterx f arr)
  (if (null? arr)
    '()
    (if (f (car arr))
      (cons (car arr) (filterx f (cdr arr)))
      (filterx f (cdr arr))
    )
  )
)

(filterx even? (cons 1 (cons 2 (cons 3 (cons 4 '())))))
(filterx even? '(1 2 4 5 3 6 8 7 9 1212))

; Pipeline

(define (pipelinex funcs x)
  (if (null? funcs)
    x
    (pipelinex (cdr funcs) ((car funcs) x))
  )
)

(define (mult2 x)
  (* x 2))

(pipelinex (cons abst (cons mult2 '())) 2)
(pipelinex (cons abst (cons mult2 '())) -2)

; Compositing functions

(define (composex funcs)
  (lambda (x)
    (reducex '() (lambda (ini f) (f x))
      funcs)
  )
)

(define absmult2 (composex (cons abst (cons mult2 '()))))
(absmult2 2)
(absmult2 -2)

(reduce + 0 '(1 2 3))

(define curry2
  (lambda (f)
    (lambda (arg1)
     (lambda (arg2)
       (f arg1 arg2)))
  ))
(define addTwoNums (curry2 +))
(define add2 (addTwoNums 2))
(add2 3)
