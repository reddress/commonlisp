;;;; Number and Problem description
;;;; 31 Pack a Sequence

;;; Write a function which packs consecutive duplicates into sub-lists

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

(defproblem pack-a-sequence
    ((equal (__ '(1 1 2 1 1 1 3 3)) '((1 1) (2) (1 1 1) (3 3)))
     (equal (__ '()) '())
     (equal (__ '(:a :a :b :b :c)) '((:a :a) (:b :b) (:c)))
     (equal (__ '((1 2) (1 2) (3 4))) '(((1 2) (1 2)) ((3 4)))))
  my-pack)

(defun my-pack (lst)
  (nreverse (my-pack-helper lst '())))

(defun my-pack-helper (lst result)
  (if (null lst)
      result
      (let ((head (car lst)))
        (if (equal head (caar result))
            (my-pack-helper (cdr lst) (cons (cons head (car result)) (cdr result)))
            (my-pack-helper (cdr lst) (cons (list head) result))))))
