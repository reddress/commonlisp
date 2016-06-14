;;;; 11 Maps: conj

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")

(defparameter *problem-11-map* (make-hash-table))
(setf (gethash :a *problem-11-map*) 1)
(setf (gethash :b *problem-11-map*) 2)
(setf (gethash :c *problem-11-map*) 3)

(defparameter *problem-11-map-b* (make-hash-table))
(setf (gethash :a *problem-11-map-b*) 1)
(setf (gethash :b *problem-11-map-b*) 2)
(setf (gethash :c *problem-11-map-b*) 3)

(defproblem maps-conj
    ((equalp *problem-11-map* *problem-11-map-b*))
  nil)

(maps-conj)
