;;;; Number and Problem description
;;;; 54 Partition a Sequence

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

;;; exclude lists of less than x items
(deftest partition-a-sequence
    ((equal (__ 3 (range 9)) '((0 1 2) (3 4 5) (6 7 8)))
     (equal (__ 2 (range 8)) '((0 1) (2 3) (4 5) (6 7)))
     (equal (__ 3 (range 8)) '((0 1 2) (3 4 5))))
  my-partition)

(defun my-partition (n lst)
  (let ((sublist '())
        (result '())
        (index 1))
    (dolist (elem lst)
      (push elem sublist)
      (when (= 0 (mod index n))
        (push (nreverse sublist) result)
        (setf sublist '()))
      (incf index))
    (nreverse result)))

(partition-a-sequence)
