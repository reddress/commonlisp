;;;; Number and Problem description
;;;; 32 Duplicate a Sequence

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

(defproblem duplicate-a-sequence
    ((equal (__ '(1 2 3)) '(1 1 2 2 3 3))
     (equal (__ '(:a :a :b :b)) '(:a :a :a :a :b :b :b :b))
     (equal (__ '((1 2) (3 4))) '((1 2) (1 2) (3 4) (3 4))))
  my-duplicate)

(defun my-duplicate (lst)
  (when lst
    (let ((head (car lst)))
      (cons head (cons head (my-duplicate (cdr lst)))))))
     
            
