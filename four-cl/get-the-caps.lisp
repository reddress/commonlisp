;;;; Number and Problem description
;;;; 29 Get the Caps

;;;; using CLISP
(if (string= "heitor-asus" (subseq (machine-instance) 0 11))  ; ubuntu
    (ext:cd "/home/heitor/commonlisp/four-cl/lib/")
    ;;;; else, in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\lib\\"))

;;;; load unit-test framework
(load "unit-test-lib.lisp")

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp :four-cl.unit-test))
(in-package :four-cl)

;;;; UPDATE file problem-list.txt

(defproblem get-the-caps
    ((string= (__ "HeLlO, WoRlD!") "HLOWRD")
     (string= "" (__ "nothing"))
     (string= (__ "$#A(*&987Zf") "AZ"))
  my-get-caps)

(defun my-get-caps (str)
  (coerce (remove-if-not #'upper-case-p (coerce str 'list))
          'string))
