(if (string= "heitor-asus" (subseq (machine-instance) 0 11))  ; ubuntu
    (ext:cd "/home/heitor/commonlisp/pcl/")
    ;;;; else, in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\pcl\\"))

(load "packages.lisp")
(load "html.lisp")
(load "pcl-unit-test.lisp")

(defpackage :hc
  (:use :common-lisp
        :pcl.unit-test
        :com.gigamonkeys.html))

(in-package :hc)

(html
 (:html
  (:head
   (:meta :charset "utf-8")
   (:title "Random numbers"))
  (:body
   (:h1 "Random numbers")
   (:p (loop repeat 10 do (html (:print (random 1000)) " "))))))
