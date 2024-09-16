; VERGARA, Ivyann Romijn H.
; Exercise 4: Scheme- Tail Recursion

; ADD ROW MATRIX
( define(AddRowMatrix lista listb sumlist)
    (if (null? lista) ; checks the list a if it is null
        sumlist
    (AddRowMatrix  (cdr lista) (cdr listb) (append sumlist (list (+ (car lista) (car listb)))) ) ; computes the sum of each element of the matrices
    )
)

;main function
(define (addMatrices sumlist)
    (define lista (car sumlist)) ; first list
    (define listb (cadr sumlist)) ; second list
    (AddRowMatrix lista listb '()) ; calls the function defined above
)
;---------------------------------------------------------------------
