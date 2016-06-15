;;;; Number and Problem description
;;;; 33 Replicate a Sequence (a variable number of times)

;;;; using CLISP
(if (string= "heitor-asus" (subseq (machine-instance) 0 11))  ; ubuntu
    (ext:cd "/home/heitor/commonlisp/four-cl/lib/")
    ;;;; else, in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\lib\\"))

;;;; load unit-test framework
(load "unit-test-lib.lisp")

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp :four-cl.unit-test))
(in-package :four-cl)

;;;; __ gets replaced by SOLUTION
;;
;; (defproblem PROBLEM-NAME
;;     ((TEST)
;;      (equal (__ n) m)  ; example
;;      ...
;;      (TEST)
;;      (TEST)*)
;;   SOLUTION)

;; Run tests
;; (PROBLEM-NAME)
     
;;;; UPDATE file problem-list.txt

(defproblem replicate-a-sequence
    ((equal (__ '(1 2 3) 2) '(1 1 2 2 3 3))
     (equal (__ '(:a :b) 4) '(:a :a :a :a :b :b :b :b))
     (equal (__ '(4 5 6) 1) '(4 5 6))
     (equal (__ '(1 2) 0) '())
     (equal (__ '((1 2) (3 4)) 2) '((1 2) (1 2) (3 4) (3 4)))
     (equal (__ '(44 33) 2) '(44 44 33 33)))
  my-replicate)

(defun my-replicate (lst times)
  (when lst
    (append (replicate-n (car lst) times) (my-replicate (cdr lst) times))))

(defun replicate-n-iter (item n result)
  (if (= n 0)
      result
      (replicate-n-iter item (- n 1) (cons item result))))

(defun replicate-n (item n)
  (replicate-n-iter item n '()))
