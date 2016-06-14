;;;; 21 Nth Element

;;; use ELT in Common Lisp

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")

(defproblem nth-element
    ((= (__ '(4 5 6 7) 2) 6)
     (eq (__ '(:a :b :c) 0) :a)
     (= (__ '(1 2 3 4) 1) 2)
     (equal (__ '((1 2) (3 4) (5 6)) 2) '(5 6)))
  my-nth)

(defun my-nth (lst n)
  (if (= n 0)
      (car lst)
      (my-nth (cdr lst) (1- n))))

(nth-element)
