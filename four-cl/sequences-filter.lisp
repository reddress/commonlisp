;;;; 18 Sequences: filter

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")

(defproblem sequences-filter
    ((equal __ (remove-if-not (lambda (x) (> x 5)) '(3 4 5 6 7))))
  '(6 7))

(sequences-filter)
