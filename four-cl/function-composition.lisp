;;;; Number and Problem description
;;;; 58 Function Composition

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

(deftest function-composition
    ((equal '(3 2 1) (funcall (__ #'rest #'reverse) '(1 2 3 4)))
     (= 5 (funcall (__ (partial #'+ 3) #'second) '(1 2 3 4)))
     (eq t (funcall (__ #'zerop #'(lambda (x) (mod x 8)) #'+) 3 5 7 9))
     ;; (string= "HELLO" (funcall (__ toUpperCase coerce take) 5 "hello world"))
     )
  my-compose)

(defun my-compose (&rest fs)
  (lambda (&rest args)
    (labels ((rec (fs)
               (if (null (cdr fs))  ; check if only one function exists
                   (apply (car fs) args)  ; args is a list
                   (funcall (car fs) (rec (cdr fs))))))  ; in subsequent calls, the arguments "fall out" of the original args list
      (rec fs))))

(defun sq (x)
  (* x x))

(defun add2 (x)
  (+ 2 x))

(defun my-compose-2 (fs)
  (lambda (&rest args)
    (apply (cadr fs) (apply (car fs) args))))
                     
