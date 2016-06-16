;;;; Number and Problem description
;;;; 59 Juxtaposition

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

(deftest juxtaposition
    ((equal '(21 6 1) (funcall (__ #'+ #'max #'min) 2 3 5 1 6 4))
     (equal '("HELLO" 5) (funcall (__ #'string-upcase #'length) "hello"))
     ;; (equal '(2 6 4) ((__ :a :c :b) '(:a 2 :b 4 :c 6 :d 8 :e 10)))
     )
  my-juxt)

(defun my-juxt (&rest fs)
  (lambda (&rest args)
    (let ((result '()))
      (dolist (f fs)
        (push (apply f args) result))
      (nreverse result))))

;; first try!
