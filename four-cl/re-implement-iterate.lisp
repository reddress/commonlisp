;;;; Number and Problem description
;;;; 62 Re-implement Iterate

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

(deftest re-implement-iterate
    ((equal (__ (lambda (x) (* 2 x)) 1 5) '(1 2 4 8 16))
     (equal (__ #'1+ 0 100) (range 100))
     ;; (equal (__ ) (take 9 (cycle '(1 2 3))))
     )
  my-iterate)

(defun my-iterate (f start n)
  (nreverse (my-iterate-helper f start n)))

;; create a list of n items
(defun my-iterate-helper (f start n)
  (if (= n 1)
      (list start)
      (let ((prev-lst (my-iterate-helper f start (- n 1))))
        (cons (funcall f (car prev-lst)) prev-lst))))
