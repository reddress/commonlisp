;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

(if (string= "heitor-asus" (subseq (machine-instance) 0 11))
    (ext:cd "/home/heitor/commonlisp/four-cl/")
    ;;;; else, using CLISP in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\"))

;;;; load unit-test framework
(load "unit-test.lisp")

;;;; UPDATE file problem-list.txt
