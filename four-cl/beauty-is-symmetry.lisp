;;;; Number and Problem description
;;;; 96 Beauty is Symmetry

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

(deftest beauty-is-symmetry
    ((eq (__ '(:a (:b nil nil) (:b nil nil))) t)
     (eq (__ '(:a (:b nil nil) nil)) nil)
     (eq (__ '(:a (:b nil nil) (:c nil nil))) nil)
     (eq (__ '(1 (2 nil (3 (4 (5 nil nil) (6 nil nil)) nil))
               (2 (3 nil (4 (6 nil nil) (5 nil nil))) nil)))
         t)
     (eq (__ '(1 (2 nil (3 (4 (5 nil nil) (6 nil nil)) nil))
               (2 (3 nil (4 (5 nil nil) (6 nil nil))) nil)))
         nil)
     (eq (__ '(1 (2 nil (3 (4 (5 nil nil) (6 nil nil)) nil))
               (2 (3 nil (4 (6 nil nil) nil)) nil)))
         nil))
  is-symmetric)

(defun is-symmetric (tree)
  (equal tree (mirror tree)))

(defun mirror (tree)
  (when tree
    (list (car tree) (mirror (caddr tree)) (mirror (cadr tree)))))
