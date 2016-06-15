;;;; Number and Problem description
;;;; 30 Compress a Sequence

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

(defproblem compress-a-sequence
    ((string= (coerce (__ (coerce "Leeeeeeerrroyyy" 'list)) 'string) "Leroy")
     (equal (__ '(1 1 2 3 3 2 2 2 3)) '(1 2 3 2 3))
     (equal (__ '((1 2) (1 2) (3 4) (1 2))) '((1 2) (3 4) (1 2))))
  my-compress)

(defun my-compress (lst)
  (nreverse (my-compress-helper lst '())))

(defun my-compress-helper (lst result)
  (if (null lst)
      result
      (let ((head (car lst)))
        (if (equal head (car result))
            (my-compress-helper (cdr lst) result)
            (my-compress-helper (cdr lst) (cons head result))))))
