;;; from Practical Common Lisp source code: Chapter09
(in-package :cl-user)

(defpackage :pcl.unit-test
  (:use :common-lisp)
  (:export :__
           :deftest))

(defpackage :hc
  (:use :common-lisp
        :pcl.unit-test))
