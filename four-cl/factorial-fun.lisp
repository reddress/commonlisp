;;;; Number and Problem description
;;;; 42 Factorial Fun

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

(defproblem factorial-recursive
    ((= (__ 1) 1)
     (= (__ 3) 6)
     (= (__ 5) 120)
     (= (__ 8) 40320))
  my-fac-rec)

(defproblem factorial-iterative
    ((= (__ 1) 1)
     (= (__ 3) 6)
     (= (__ 5) 120)
     (= (__ 8) 40320))
  my-fac-iter)

(defproblem factorial-reductive
    ((= (__ 1) 1)
     (= (__ 3) 6)
     (= (__ 5) 120)
     (= (__ 8) 40320))
  my-fac-reductive)

(defproblem factorial-tests
    ((factorial-recursive)
     (factorial-iterative)
     (factorial-reductive)))

(defun my-fac-rec (n)
  (if (< n 2)
      1
      (* n (my-fac-rec (- n 1)))))

(defun my-fac-iter (n)
  (my-fac-iter-helper n 1))

(defun my-fac-iter-helper (n product)
  (if (= n 1)
      product
      (my-fac-iter-helper (- n 1) (* n product))))

(defun my-fac-reductive (n)
  (reduce #'* (loop for i from 1 to n collect i)))
