;;;; Number and Problem description
;;;; 53 Longest Increasing Sub-Seq

;;; keep track of two subsequences, "current" and "longest"
;;; replace "longest" with "current" when
;;;    length of current > length of longest

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

(deftest longest-increasing-sub-seq
    ((equal (__ '(1 0 1 2 3 0 4 5)) '(0 1 2 3))
     (equal (__ '(5 6 1 3 2 7)) '(5 6))
     (equal (__ '(2 3 3 4 5)) '(3 4 5))
     (equal (__ '(6 7 8 1 3 4)) '(6 7 8))
     (equal (__ '(7 6 5 4)) '()))
  my-longest-inc)

(defun my-longest-inc (lst)
  (let ((current-seq (list (car lst)))
        (longest-seq '())
        (current-elem (car lst)))
    (dolist (elem (cdr lst))
      (if (> elem current-elem)
          (push elem current-seq)
          (setf current-seq (list elem)))
      ;; update longest-seq
      (when (and (> (length current-seq) 1)
                 (> (length current-seq) (length longest-seq)))
        (setf longest-seq current-seq))

      ;; update current-elem 
      (setf current-elem elem))
    (nreverse longest-seq)))

(longest-increasing-sub-seq)
