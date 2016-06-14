;;;; 24 Sum it all up

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")

;;;; UPDATE file problem-list.txt

(defproblem sum-it-all-up
    ((= (__ '(1 2 3)) 6)
     (= (__ (list 0 -2 5 5)) 8)
     (= (__ '(0 0 -1)) -1))
  ;; my-sum)  ; iterative solution
  (lambda (lst) (reduce #'+ lst)))

(defun my-sum (lst)
  (my-sum-iter lst 0))

(defun my-sum-iter (lst total)
  (if (null lst)
      total
      (my-sum-iter (cdr lst) (+ (car lst) total))))

(sum-it-all-up)
