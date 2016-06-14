;;;; 20 Penultimate Element

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")

(defproblem penultimate-element
    ((= (__ '(1 2 3 4 5)) 4)
     (string= (__ '("a" "b" "c")) "b")
     (equal (__ '((1 2) (3 4))) '(1 2)))
  my-penultimate)

(defun my-penultimate (lst)
  (if (null (cddr lst))
      (car lst)
      (my-penultimate (cdr lst))))

(penultimate-element)
