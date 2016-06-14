;;;; 23 Reverse a Sequence

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")

;;;; UPDATE file problem-list.txt

(defproblem reverse-a-sequence
    ((equal (__ '(1 2 3 4 5)) '(5 4 3 2 1))
     (equal (__ '(2 5 7)) '(7 5 2))
     (equal (__ '((1 2) (3 4) (5 6))) '((5 6) (3 4) (1 2))))
  my-reverse)

(defun my-reverse (lst)
  (my-reverse-iter lst '()))

(defun my-reverse-iter (lst result)
  (if (null lst)
      result
      (my-reverse-iter (cdr lst) (cons (car lst) result))))

(reverse-a-sequence)
