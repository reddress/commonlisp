;;;; 10 Intro to Maps

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")

(defparameter *problem-10-map* (make-hash-table))
(setf (gethash :a *problem-10-map*) 10)
(setf (gethash :b *problem-10-map*) 20)
(setf (gethash :c *problem-10-map*) 30)
 
(defproblem intro-to-maps
    ((= __ (gethash :b *problem-10-map*)))
  20)

(intro-to-maps)
