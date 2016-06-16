;;;; Number and Problem description
;;;; 60 Sequence Reductions

;; Note: Not making the return value lazy

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

(deftest sequence-reductions
    ((equal '(0 1 3 6 10) (__ #'+ (range 5)))
     ;; (equal (__ conj) '())
     (= (car (last (__ #'* 2 '(3 4 5)))) (reduce #'* '(2 3 4 5)) 120))
  
  my-intermediate-reduction)

;;; if given three arguments, append second argument as head of third
;;; argument (the list) and call two-argument version

(defun my-intermediate-reduction (f lst-or-start &optional lst)
  (if lst
      (my-intermediate-reduction-helper f (cons lst-or-start lst))
      (my-intermediate-reduction-helper f lst-or-start)))

(defun my-intermediate-reduction-helper (f lst)
  (let ((result (list (car lst))))
    (dolist (elem (cdr lst))
      (push (funcall f (car result) elem) result))
    (nreverse result)))
      
(defun my-reduce (f lst)
  (if (null (cddr lst))
      (funcall f (car lst) (cadr lst))
      (funcall f (car lst) (my-reduce f (cdr lst)))))
