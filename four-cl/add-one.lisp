;;;; using CLISP
(if (string= "heitor-asus" (subseq (machine-instance) 0 11))  ; ubuntu
    (ext:cd "/home/heitor/commonlisp/four-cl/lib/")
    ;;;; else, in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\lib\\"))

;;;; load unit-test framework
(load "unit-test-lib.lisp")

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp :four-cl.unit-test))
(in-package :four-cl)

;;;; UPDATE file problem-list.txt

(defproblem add-one
    ((equal (__ 1) 2))
  1+)

(defproblem add-one-my-solution
    ((equal (__ 1) 2))
  (lambda (x) (+ 1 x)))

(defproblem add-one-defined-elsewhere
    ((equal (__ 1) 2))
  my-add-one)

(defun my-add-one (x)
  (+ 1 x))
