;;;; EXTRA: Flatten only one level deep

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

(if (string= "heitor-asus" (subseq (machine-instance) 0 11))
    (ext:cd "/home/heitor/commonlisp/four-cl/")
    ;;;; else, using CLISP in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\"))

;;;; load unit-test framework
(load "unit-test.lisp")

;;;; UPDATE file problem-list.txt

(defproblem flatten-one-level
    ((equal (__ '((1) 2)) '(1 2))
     (equal (__ '(1 2)) '(1 2))
     (equal (__ '((((1))) 2)) '(((1)) 2))
     (equal (__ '((1 2) 3 (4 ((5))))) '(1 2 3 4 ((5)))))
  my-flatten-one-level)

(defun my-flatten-one-level (lst)
  (when lst
    (let ((head (car lst)))
      (if (atom head)
          (cons head (my-flatten-one-level (cdr lst)))
          (append head (my-flatten-one-level (cdr lst)))))))

(flatten-one-level)
