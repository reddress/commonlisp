;;;; Number and Problem description
;;;; 63 Group a Sequence

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

(deftest test-group-a-sequence
    ((let ((hash-1 (__ (lambda (x) (> x 5)) '(1 3 6 8))))
       (and (equal (gethash nil hash-1) '(1 3))
            (equal (gethash t hash-1) '(6 8))))
     (let ((hash-2 (__ (lambda (lst) (apply #'/ lst))
                       '((1 2) (2 4) (4 6) (3 6)))))
       (and (equal (gethash 1/2 hash-2) '((1 2) (2 4) (3 6)))
            (equal (gethash 2/3 hash-2) '((4 6)))))
     (let ((hash-3 (__ #'length '((1) (1 2) (3) (1 2 3) (2 3)))))
       (and (equal (gethash 1 hash-3) '((1) (3)))
            (equal (gethash 2 hash-3) '((1 2) (2 3)))
            (equal (gethash 3 hash-3) '((1 2 3))))))
  group-a-sequence)

(defun group-a-sequence (f lst)
  (let ((result (make-hash-table)))
    (dolist (elem lst)
      (let ((f-val (funcall f elem)))
        (if (gethash f-val result)
            (push elem (gethash f-val result))
            (setf (gethash f-val result) (list elem)))))
    (maphash (lambda (k v) (setf (gethash k result) (reverse v))) result)
    result))

