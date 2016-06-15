;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")

;;;; 38 Maximum value

(defun my-max (&rest lst)
  (my-max-helper (car lst) lst))

(defun my-max-helper (cur-max lst)
  (if (null lst)
      cur-max
      (let ((head (car lst)))
        (my-max-helper
         (if (> head cur-max)
             head
             cur-max)
         (cdr lst)))))

(defproblem problem-38
    ((= (__ 1 8 3 4) 8)
     (= (__ 30 20) 30)
     (= (__ 45 67 11) 67)
     (= (__ -3 -1 -2) -1))
  my-max)
