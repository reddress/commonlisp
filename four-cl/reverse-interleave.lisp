;;;; Number and Problem description
;;;; 43 Reverse Interleave

;;;; using CLISP
(if (string= "heitor-asus" (subseq (machine-instance) 0 11))  ; ubuntu
    (ext:cd "/home/heitor/commonlisp/four-cl/lib/")
    ;;;; else, in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\lib\\"))

;;;; load unit-test framework
(load "unit-test-lib.lisp")
(load "extra.lisp")

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


(defproblem reverse-interleave
    ((equal (__ '(1 2 3 4 5 6) 2) '((1 3 5) (2 4 6)))
     (equal (__ (range 9) 3) '((0 3 6) (1 4 7) (2 5 8)))
     (equal (__ (range 10) 5) '((0 5) (1 6) (2 7) (3 8) (4 9))))
  my-reverse-interleave)

(defun my-reverse-interleave (lst n)
  (mapcar #'reverse
          (my-reverse-interleave-helper lst n 0 (repeat n '()))))

;;; return first n elements of a list
(defun first-n (n lst)
  (reverse
   (nthcdr (- (length lst) n) (reverse lst))))

(defun cons-to-sublist (new-elt n superlist)
  (append (first-n n superlist)
          (cons (cons new-elt (nth n superlist))
                (nthcdr (+ n 1) superlist))))

;;; cons car of lst to ith list in result
(defun my-reverse-interleave-helper (lst n i result)
  (if (null lst)
      result
      (my-reverse-interleave-helper (cdr lst)
                                    n
                                    (+ i 1)
                                    (cons-to-sublist (car lst) (mod i n) result))))
