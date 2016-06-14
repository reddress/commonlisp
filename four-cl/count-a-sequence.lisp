;;;; 22 Count a Sequence

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; load unit-test framework
(load "unit-test.lisp")

;;;; UPDATE file problem-list.txt

(defproblem count-a-sequence
    ((= (__ '(1 2 3 3 1)) 5)
     ;; (= (__ "Hello World") 11)  ; Ignore. String is not a list
     (= (__ '((1 2) (3 4) (5 6))) 3)
     (= (__ '(12)) 1)
     (= (__ '(:a :b :c)) 3))
  my-count)

(defun my-count (lst)
  (if (null lst)
      0
      (1+ (my-count (cdr lst)))))

(count-a-sequence)
