;;;; 17 Sequences: map

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")

(defproblem sequences-map
    ((equal __ (mapcar (lambda (x) (+ x 5)) '(1 2 3))))
  '(6 7 8))

(sequences-map)
