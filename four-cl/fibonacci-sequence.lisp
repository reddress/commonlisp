;;;; 26 Fibonacci Sequence

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")

;;;; UPDATE file problem-list.txt

(defproblem fibonacci-sequence
    ((equal (__ 3) '(1 1 2))
     (equal (__ 0) '())
     (equal (__ 1) '(1))
     (equal (__ 2) '(1 1))
     (equal (__ 6) '(1 1 2 3 5 8))
     (equal (__ 8) '(1 1 2 3 5 8 13 21)))
  my-fib)

(defun my-fib (n)
  (reverse (my-fib-builder n)))

(defun my-fib-builder (n)
  (cond ((= n 0) '())
        ((= n 1) '(1))
        ((= n 2) '(1 1))
        (t (let ((prev-result (my-fib-builder (- n 1))))
             (cons (+ (car prev-result) (cadr prev-result))
                   prev-result)))))

(fibonacci-sequence)
