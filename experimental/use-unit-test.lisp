;;;; using CLISP
(if (string= "heitor-asus" (subseq (machine-instance) 0 11))  ; ubuntu
    (ext:cd "/home/heitor/commonlisp/lib/")
    ;;;; else, in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\lib\\"))

(load "pcl-unit-test.lisp")

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :hc
  (:use :common-lisp :ext :pcl.unit-test))
(in-package :hc)

(deftest test-keep-first-element
    ((equal '("a") (__ '("a" "b")))
     (equal '(1) (__ '(1 2 3)))
     (equal '((:x :y)) (__ '((:x :y) (:z) :a))))
  keep-first)

(defun keep-first (lst)
  (list (car lst)))

(test-keep-first-element)
               
