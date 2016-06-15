;;;; using CLISP
(if (string= "heitor-asus" (subseq (machine-instance) 0 11))  ; ubuntu
    (ext:cd "/home/heitor/commonlisp/")
    ;;;; else, in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\"))
;;;; full package name :io.github.heitorchang.four-cl
(defpackage :hc
  (:use :common-lisp :ext))
(in-package :hc)
