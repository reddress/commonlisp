;;;; Number and Problem description
;;;; 39 Interleave Two Seqs

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

(defproblem interleave-two-seqs
    ((equal (__ '(1 2 3) '(:a :b :c)) '(1 :a 2 :b 3 :c))
     (equal (__ '(1 2) '(3 4 5 6)) '(1 3 2 4))
     (equal (__ '(1 2 3 4) '(5)) '(1 5))
     (equal (__ '(30 20) '(25 15)) '(30 25 20 15)))
  my-interleave)

(defun my-interleave (a b)
  (nreverse 
   (my-interleave-helper a b '())))

(defun my-interleave-helper (a b result)
  (if (or (null a) (null b))
      result
      (my-interleave-helper (cdr a) (cdr b)
                            (cons (car b) (cons (car a) result)))))
