;;;; Number and Problem description
;;;; 72 Rearranging Code: ->>

;;;; using CLISP
(if (string= "heitor-asus" (subseq (machine-instance) 0 11))  ; ubuntu
    (ext:cd "/home/heitor/commonlisp/lib/")
    ;;;; else, in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\lib\\"))

;;;; load unit-test framework
(load "pcl-unit-test.lisp")
(load "threading.lisp")

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp
        :pcl.unit-test
        :hc-lib.threading))
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

;;; helper functions
(setf (fdefinition 'drop) #'nthcdr)

(defun take (n lst)
  (reverse (drop (- (length lst) n) (reverse lst))))

(deftest test-rearranging-code-thread-last
    ((= (__ (mapcar #'1+ (take 3 (drop 2 '(2 5 4 1 3 6)))))
        (->> '(2 5 4 1 3 6) (drop 2) (take 3) (mapcar #'1+) (__))
        11))
  apply #'+)

(test-rearranging-code-thread-last)
