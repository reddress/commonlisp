;;;; 15 Double Down

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")

(defproblem double-down
    ((= (__ 2) 4)
     (= (__ 11) 22)
     (= (__ 7) 14))
  (lambda (x) (* 2 x)))

(double-down)
     
