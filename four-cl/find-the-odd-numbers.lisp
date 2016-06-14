;;;; 25 Find the Odd Numbers

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")

;;;; UPDATE file problem-list.txt

(defproblem find-the-odd-numbers
    ((equal (__ '(1 2 3 4 5)) '(1 3 5))
     (equal (__ '(4 2 1 6)) '(1))
     (equal (__ '(2 2 4 6)) '())
     (equal (__ '(1 1 1 3)) '(1 1 1 3)))
  ;; my-find-odd)  ; recursive procedure
  remove-if-not #'oddp)

(defun my-find-odd (lst)
  (when lst
    (let ((head (car lst)))
      (if (oddp head)
          (cons head (my-find-odd (cdr lst)))
          (my-find-odd (cdr lst))))))

(find-the-odd-numbers)
