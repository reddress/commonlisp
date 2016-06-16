;;;; Number and Problem description
;;;; 56 Find Distinct Items

;;;; using CLISP
(if (string= "heitor-asus" (subseq (machine-instance) 0 11))  ; ubuntu
    (ext:cd "/home/heitor/commonlisp/lib/")
    ;;;; else, in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\lib\\"))

;;;; load unit-test framework
(load "pcl-unit-test.lisp")
(load "hc-extra.lisp")

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

(deftest find-distinct-items
    ((equal (__ '(1 2 1 3 1 2 4)) '(1 2 3 4))
     (equal (__ '(:a :a :b :b :c :c)) '(:a :b :c))
     (equal (__ '((2 4) (1 2) (1 3) (1 3))) '((2 4) (1 2) (1 3)))
     (equal (__ (range 50)) (range 50)))
  my-find-distinct)

(defun my-find-distinct (lst)
  (let ((result '()))
    (dolist (elem lst)
      (unless (position elem result :test 'equal)
        (push elem result)))
    (nreverse result)))

(find-distinct-items)
