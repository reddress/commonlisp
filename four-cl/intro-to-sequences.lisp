;;;; 12 Intro to Sequences

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")


(defproblem intro-to-sequences
    ((= __ (first '(3 2 1)))
     (= __ (second '(2 3 4)))
     (= __ (elt #(2 3 4) 1))
     (= __ (car (last (list 1 2 3)))))
  3)

(intro-to-sequences)
