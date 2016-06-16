;;;; Number and Problem description
;;;; 51 Advanced Destructuring

;;;; using CLISP
(if (string= "heitor-asus" (subseq (machine-instance) 0 11))  ; ubuntu
    (ext:cd "/home/heitor/commonlisp/lib/")
    ;;;; else, in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\lib\\"))

;;;; load unit-test framework
(load "pcl-unit-test.lisp")

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp :pcl.unit-test))
(in-package :four-cl)

;;;; __ gets replaced by SOLUTION
;;
;; (deftest PROBLEM-NAME
;;     ((TEST)
;;      (equal (__ n) m)  ; example
;;      ...
;;      (TEST)
;;      (TEST)*)
;;   SOLUTION)

;; Run tests
;; (PROBLEM-NAME)
     
;;;; UPDATE file problem-list.txt after solving

(deftest advanced-destructuring
    ((equal '(1 2 (3 4 5) (1 2 3 4 5))
            (destructuring-bind (&whole d a b &rest c)
                (list __)
              (list a b c d))))
  1 2 3 4 5)

(advanced-destructuring)

(destructuring-bind (&whole d a b &rest c)
    (list 1 2 3 4 5)
  (list a b c d))
