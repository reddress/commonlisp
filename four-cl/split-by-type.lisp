;;;; Number and Problem description
;;;; 50 Split by Type

;;; Using assignment to build result

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

(deftest split-by-type
    ((equal (__ '(10 :a 2 :b 3 :c)) '((10 2 3) (:a :b :c)))  ; original had 1, but CL considers it a BIT and not INTEGER
     (equal (__ '(:a "foo" "bar" :b)) '((:a :b) ("foo" "bar")))
     (equal (__ '((1 2) :a (3 4) 5 6 :b)) '(((1 2) (3 4)) (:a :b) (5 6))))
  my-split)


(defun my-split (lst)
  (let* ((lst-types (get-types lst))
         (result (repeat (length lst-types) '())))
    (dolist (elem lst)
      ;; (format t "~a~%" (general-type-of elem))
      (push elem (nth (position (general-type-of elem) lst-types) result)))
    (mapcar #'nreverse result)))
  
(defun get-types-helper (lst result)
  (if (null lst)
      result
      (let ((general-type-of-first (general-type-of (car lst))))
        (if (position general-type-of-first result)
            (get-types-helper (cdr lst) result)
            (get-types-helper (cdr lst) (cons general-type-of-first result))))))

(defun get-types (lst)
  (nreverse (get-types-helper lst '())))

(defun general-type-of (x)
  (let ((type (type-of x)))
    (if (consp type)
        (car type)
        type)))

