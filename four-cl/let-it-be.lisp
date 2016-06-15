;;;; Number and Problem description
;;;; 36 Let it Be

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
     
;;;; UPDATE file problem-list.txt

(defproblem let-it-be
    ((= 10 (let __ (+ x y)))
     (= 4 (let __ (+ y z)))
     (= 1 (let __ z)))
  ((z 1)
   (y 3)
   (x 7)))

(let-it-be)
