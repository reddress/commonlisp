;;;; Number and Problem description
;;;; 46 Flipping out

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

;;;; __ gets replaced by SOLUTION
;;
;; (defproblem PROBLEM-NAME
;;     ((TEST)
;;      (equal (__ n) m)  ; example
;;      ...
;;      (TEST)
;;      (TEST)*)
;;   SOLUTION)

;; Run tests
;; (PROBLEM-NAME)
     
;;;; UPDATE file problem-list.txt after solving

(defproblem flipping-out
    ((= 3 (funcall (__ #'nth) '(1 2 3 4 5) 2))  ; arguments are reversed in clj
     (eq t (funcall (__ #'>) 7 8))
     (= 4 (funcall (__ #'/) 2 8))
     (equal '(1 2 3) (funcall (__ #'first-n) '(1 2 3 4 5) 3)))
  my-flip)

(defun my-flip (f)
  (lambda (a b)
    (funcall f b a)))
