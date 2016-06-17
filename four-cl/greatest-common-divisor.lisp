;;;; Number and Problem description
;;;; 66 Greatest Common Divisor

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

(deftest test-greatest-common-divisor
    ((= (__ 2 4) 2)
     (= (__ 10 5) 5)
     (= (__ 5 7) 1)
     (= (__ 1023 858) 33))
  my-gcd)

;;; just like SICP
(defun my-gcd (a b)
  (if (= b 0)
      a
      (my-gcd b (rem a b))))

;;;; if a < b, then (rem a b) = a, so a and b switch places
