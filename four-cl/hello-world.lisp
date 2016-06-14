;;;; 16 Hello World

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")

(defproblem hello-world
    ((string= (__ "Dave") "Hello, Dave!"))
  (lambda (name)
    (concatenate 'string "Hello, " name "!")))

(hello-world)
