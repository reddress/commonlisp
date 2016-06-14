;;;; 27 Palindrome Detector

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")

;;;; UPDATE file problem-list.txt

(defproblem palindrome-detector
    ((not (__ '(1 2 3 4 5)))
     ;; (__ "racecar")  ; String is not a list
     (__ '(:foo :bar :foo))
     (__ '(1 1 3 3 1 1))
     (not (__ '(:a :b :c))))
  (lambda (lst) (equal lst (reverse lst))))

(palindrome-detector)
