;;;; Number and Problem description
;;;; EXTRA: Repeat a list

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

;;;; UPDATE file problem-list.txt

(defproblem repeat-a-list
    ((equal (__ '(1 2)) '(1 2 1 2))
     (equal (__ '()) '())
     (equal (__ '((1) (2 ((3))))) '((1) (2 ((3))) (1) (2 ((3))))))
  ;; (lambda (lst) (append lst lst)))  ; easy solution
  my-repeat)

(defun my-repeat (lst)
  (my-repeat-helper (reverse lst) lst))

(defun my-repeat-helper (a result)
  (if (null a)
      result
      (my-repeat-helper (cdr a) (cons (car a) result))))

(repeat-a-list)
