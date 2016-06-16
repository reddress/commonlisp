;;;; Number and Problem description
;;;; EXTRA: partial

;;;; using CLISP
(if (string= "heitor-asus" (subseq (machine-instance) 0 11))  ; ubuntu
    (ext:cd "/home/heitor/commonlisp/lib/")
    ;;;; else, in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\lib\\"))

;;;; load unit-test framework
(load "pcl-unit-test.lisp")

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp :pcl.unit-test))
(in-package :four-cl)

;;;; __ gets replaced by SOLUTION
;;
;; (deftest PROBLEM-NAME
;;     ((TEST)
;;      (equal (__ n) m)  ; example
;;      ...
;;      (TEST)
;;      (TEST)*)
;;   SOLUTION)

;; Run tests
;; (PROBLEM-NAME)
     
;;;; UPDATE file problem-list.txt after solving

(defun partial (f &rest args)
  (lambda (&rest new-args)
    (apply f (append args new-args))))

(deftest test-partial
    ((= 8 (funcall (partial #'+ 3) 5))))

(test-partial)
