;;;; EXTRA: Append
;;;; Reproduce the behavior of append, for two lists only (builtin
;;;; takes any number of lists

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")

;;;; UPDATE file problem-list.txt

(defproblem test-my-append
    ((equal (__ '(a b c) '(d e f)) '(a b c d e f))
     (equal (__ '((a)) '(b)) '((a) b))
     (equal (__ '((((a))) (b)) '(c)) '((((a))) (b) c)))
  my-append)

(defun my-append (a b)
  (my-append-helper (reverse a) b))

(defun my-append-helper (a b)
  (if (null a)
      b
      (my-append-helper (cdr a) (cons (car a) b))))

(test-my-append)
