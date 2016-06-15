;;;; Number and Problem description
;;;; 40 Interpose a Seq

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

(defproblem interpose-a-seq
    ((equal (__ 0 '(1 2 3)) '(1 0 2 0 3))
     (string= (apply #'concatenate 'string (__ ", " '("one" "two" "three"))) "one, two, three")
     (equal (__ :z '(:a :b :c :d)) '(:a :z :b :z :c :z :d)))
  my-interpose)

(defun my-interpose (val lst)
  ;; remove last element
  (reverse
   (cdr (reverse (my-interpose-helper val lst)))))

(defun my-interpose-helper (val lst)
  (when lst
    (cons (car lst) (cons val (my-interpose-helper val (cdr lst))))))
