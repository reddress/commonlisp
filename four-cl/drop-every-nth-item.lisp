;;;; Number and Problem description
;;;; 

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
     
;;;; UPDATE file problem-list.txt after solving

(defproblem drop-every-nth
    ((equal (__ '(1 2 3 4 5 6 7 8) 3) '(1 2 4 5 7 8))
     (equal (__ '(:a :b :c :d :e :f) 2) '(:a :c :e))
     (equal (__ '(1 2 3 4 5 6) 4) '(1 2 3 5 6)))
  my-drop-nth)

(defun my-drop-nth (lst n)
  (my-drop-nth-helper lst n 1))

(defun my-drop-nth-helper (lst n i)
  (when lst
    (if (= 0 (mod i n))
        (my-drop-nth-helper (cdr lst) n (+ i 1))
        (cons (car lst) (my-drop-nth-helper (cdr lst) n (+ i 1))))))

(drop-every-nth)
