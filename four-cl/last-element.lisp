;;;; 19 Last Element

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")

(defproblem last-element
    ((= (__ '(1 2 3 4 5)) 5)
     (= (__ '(5 4 3)) 3)
     (string= (__ '("b" "c" "d")) "d"))
  my-last)

(defun my-last (lst)
  (if (null (cdr lst))
      (car lst)
      (my-last (cdr lst))))

(last-element)
