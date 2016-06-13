(defmacro replace-blank (form &rest replacements)
  (apply #'my-subst form '*blank* replacements))

;; (macroexpand-1
(replace-blank
 (deftest test-4 ()
   (equal (list *blank*) '(:a :b :c)))
 :a :b :c)
;; )  ; victory
 
(subst '*value* '*blank* '(1 (*blank*)
                           3 *blank*))

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
    (equal *blank* (+ 1 1))
    (equal *blank* (/ 6 3))
    (equal *blank* (- 9 7))))
 2)

(test-a-1)
 
           
