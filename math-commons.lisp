;;; range, combinations, permutations, factors, etc

;;;; experimental/combination-and-permutation-my-npm.lisp

;;; Technique from Foundations of Computer Science
;; Basis (n C 0) = 1 (picking nothing)
;; (n C n) = 1 (pick everything)

;; (n C m) = (n-1 C m) + (n-1 C m-1)
;; i) Do not pick the first element, and pick m things from the
;; remaining n-1 elements: (n-1 C m)

;; ii) Pick the first element and select m-1 things from the
;; remaining n-1 elements: (n-1 C m-1)

;; choose m items from lst
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

;; permutations of m items from lst
(defun npm (lst m)
  (npm-helper lst m (- (length lst) 1)))

;;;; four-cl/prime-numbers.lisp

(defun is-prime (n)
  (dotimes (i (isqrt n))
    (let ((test-factor (+ i 2)))  ; really only need to go to sqrt(n)
      (if (= 0 (rem n test-factor))
          (return-from is-prime nil))))
  t)

;;; given n, find the next number greater than n that is prime
(defun next-prime (n)
  (let ((next-int (+ n 1)))
    (if (is-prime next-int)
        next-int
        (next-prime next-int))))

(defun first-divisor (n)
  (dotimes (i (isqrt n))
    (let ((j (+ i 2)))
      (if (= 0 (rem n j))
          (return-from first-divisor j))))
  n)
  
(defun factor (n)
  (if (= n 1)
      '()
      (let ((divisor (first-divisor n)))
        (cons divisor (factor (/ n divisor)))))) 
