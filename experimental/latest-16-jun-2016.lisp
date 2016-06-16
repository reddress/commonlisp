(if (string= "heitor-asus" (subseq (machine-instance) 0 11))  ; ubuntu
    (ext:cd "/home/heitor/commonlisp/pcl/")
    ;;;; else, in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\pcl\\"))

(load "packages.lisp")
(load "html.lisp")
(load "pcl-unit-test.lisp")

;;; full package name io.github.heitorchang
(defpackage :hc
  (:use :common-lisp
        :pcl.unit-test
        :com.gigamonkeys.html))

(in-package :hc)

(deftest test-my-function
    ((= (__ 9) 10))
  my-add-one)

(defun my-add-one (x)
  (+ x 1))
    
