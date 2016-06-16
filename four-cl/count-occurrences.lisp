;;;; Number and Problem description
;;;; 55 Count Occurrences

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

(deftest count-occurrences
    ((let ((hash-1 (__ '(1 1 2 3 2 1 1))))
      (and (= (gethash 1 hash-1) 4)
           (= (gethash 2 hash-1) 2)
           (= (gethash 3 hash-1) 1)))
     (let ((hash-2 (__ '(:b :a :b :a :b))))
       (and (= (gethash :a hash-2) 2)
            (= (gethash :b hash-2) 3)))
     (let ((hash-3 (__ '((1 2) (1 3) (1 3)))))
       (and (= (gethash '(1 2) hash-3) 1)
            (= (gethash '(1 3) hash-3) 2))))
  my-count)

(defun my-count (lst)
  (let ((result (make-hash-table :test 'equal)))  ; equal for lists as keys
    (dolist (elem lst)
      (let ((hash-ref (gethash elem result)))
        (if hash-ref
            (incf (gethash elem result))
            (setf (gethash elem result) 1))))
    result))
