;; Basis (n C 0) = 1 (picking nothing)
;; (n C n) = 1 (pick everything)

;; (n C m) = (n-1 C m) + (n-1 C m-1)
;; i) Do not pick the first element, and pick m things from the
;; remaining n-1 elements: (n-1 C m)

;; ii) Pick the first element and select m-1 things from the
;; remaining n-1 elements: (n-1 C m-1)

(defun ncm (lst m)
  (cond ((= 0 m) '(()))
        ((null lst) '())
        (t (append (mapcar #'(lambda (x) (cons (car lst) x))
                           (ncm (cdr lst) (- m 1)))
                   (ncm (cdr lst) m)))))


;; ((a) (b) (c))
(defun rotate-left (lst remaining)
  (if (= remaining 0)
      nil
      (append (cdr lst) (list (car lst)))))

(defun npm-helper (lst m j)
  (cond ((= m 0) '(()))
        ((null lst) '())
        (t (append (mapcar #'(lambda (x) (cons (car lst) x))
                           (npm-helper (cdr lst) (- m 1) (- (length (cdr lst)) 1)))
                   (npm-helper (rotate-left lst j) m (- j 1))))))

;; (append (

(defun npm (lst m)
  (npm-helper lst m (- (length lst) 1)))
