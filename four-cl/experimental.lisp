(defmacro replace-blank (form &rest replacements)
  (apply #'my-subst form '__ replacements))

;; (macroexpand-1
(replace-blank
 (deftest test-4 ()
   (equal (list __) '(:a :b :c)))
 :a :b :c)
;; )  ; victory
 
(subst '*value* '__ '(1 (__)
                           3 __))

(defun my-substitute (form old &rest new)
  (when form
    (if (equal (car form) old)
        (append new
                (apply #'my-substitute (cdr form) old new))
        (cons (car form)
              (apply #'my-substitute (cdr form) old new)))))

(defun my-subst (form old &rest new)
  (when form
    (if (equal (car form) old)
        (append new
                (apply #'my-subst (cdr form) old new))
        (if (listp (car form))
            (cons (apply #'my-subst (car form) old new)
                  (apply #'my-subst (cdr form) old new))
            (cons (car form)
                  (apply #'my-subst (cdr form) old new))))))


(defun my-splice (target &rest elts)
  (if (null elts)
      target
      (cons (car elts) (apply #'my-splice target (cdr elts)))))

(defun my-splice-2 (target &rest elts)
  (append elts target))

(defun echo-tree (a)
  (when a
    (if (listp (car a))
        (cons (car a) (echo-tree (cdr a)))
        (cons (car a) (echo-tree (cdr a))))))

(replace-blank
 (deftest test-a-1 ()
   (check
    (equal __ (+ 1 1))
    (equal __ (/ 6 3))
    (equal __ (- 9 7))))
 2)

(test-a-1)
 
(defun range-1 (n)
  (loop for i from 1 to n collecting i))

(defun range (n)
  (loop for i from 0 to (- n 1) collecting i))

(defun my-lambdas-loop (n)
  (loop for i from 0 to n collecting
       (lambda (m) (+ i m))))

(defun my-lambdas-cons (n)
  (if (= n 0)
      ()
      (cons (lambda (m) (+ m n))
            (my-lambdas-cons (- n 1)))))

(defmacro defproblem (name tests solution)
  `(replace-blank
    (deftest ,name ()
      (check
       ,@tests))
    ,solution))

(macroexpand-1 
'(defproblem problem-square
    ((= (__ 3) 9)
     (= (__ -1) 1))
  (lambda (x) (* x x))))

(defproblem problem-square
    ((= (__ 3) 9))
  (lambda (x) (* x x)))

(defun problem-symbol (n)
  (intern (concatenate 'string "PROBLEM-" (write-to-string n))))

(defun problem-range (start end)
  (loop for i from start to end collecting (list (problem-symbol i))))

(defmacro combine-problem-tests (start end)
  `(deftest problem-range-tests ()
     (combine-results
      ,@(problem-range start end))))
