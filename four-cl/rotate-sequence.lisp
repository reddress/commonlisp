;;;; Number and Problem description
;;;; 44 Rotate Sequence

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

(defproblem rotate-sequence
    ((equal (__ 2 '(1 2 3 4 5)) '(3 4 5 1 2))
     (equal (__ -2 '(1 2 3 4 5)) '(4 5 1 2 3))
     (equal (__ 6 '(1 2 3 4 5)) '(2 3 4 5 1))
     (equal (__ 1 '(:a :b :c)) '(:b :c :a))
     (equal (__ -4 '(:a :b :c)) '(:c :a :b)))
  my-rotate)
 
;; 1 2 3 4 5  :0 -5
;; 2 3 4 5 1  :1 -4 
;; 3 4 5 1 2  :2 -3
;; 4 5 1 2 3  :3 -2
;; 5 1 2 3 4  :4 -1
;; 1 2 3 4 5  :5  0
;; 2 3 4 5 1  :6

(defun my-rotate (n lst)
  (if (= n 0)
      lst
      (if (< n 0)
          (my-rotate (+ n (length lst)) lst)
          (my-rotate (- n 1) (rotate-left lst)))))

(defun rotate-left (lst)
  (append (cdr lst) (list (car lst))))
