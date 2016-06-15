;;;; Number and Problem description
;;;; 34 Implement range

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

(defproblem implement-range
    ((equal (__ 1 4) '(1 2 3))
     (equal (__ -2 2) '(-2 -1 0 1))
     (equal (__ 5 8) '(5 6 7)))
  hc-range)

(defun hc-range (start end)
  (nreverse (hc-range-helper start end '())))

(defun hc-range-helper (start end result)
  (if (= start end)
      result
      (hc-range-helper (+ start 1) end (cons start result))))
