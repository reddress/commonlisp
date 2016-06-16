;;;; Number and Problem description
;;;; 49 Split a sequence

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

(deftest split-a-sequence
    ((equal (__ 3 '(1 2 3 4 5 6)) '((1 2 3) (4 5 6)))
     (equal (__ 1 '(:a :b :c :d)) '((:a) (:b :c :d)))
     (equal (__ 2 '((1 2) (3 4) (5 6))) '(((1 2) (3 4)) ((5 6)))))
  my-split)

(defun my-split (n lst)
  ;; (let ((first-n (reverse (nthcdr (- (length lst) n) (reverse lst)))))  ; ugly
  (let ((first-n (nreverse (accumulate-first-n n lst '()))))
    (cons first-n (list (nthcdr n lst)))))

(defun accumulate-first-n (n lst result)
  (if (= n 0)
      result
      (accumulate-first-n (- n 1) (cdr lst) (cons (car lst) result))))

(split-a-sequence)
