;;;; usage

;; (deftest TEST-NAME
;;     (TEST-1
;;      TEST-2
;;      (equal '(1) (__ 1 2 3))  ; example
;;      ...
;;      TEST-N)
;;   FORMS-TO-FILL-IN-THE-BLANK)

;; FORMS-TO-FILL-IN-THE-BLANK may be omitted if no blanks are used

;; EXAMPLE
;;
;; (deftest test-keep-first-element
;;     ((equal '("a") (__ '("a" "b")))
;;      (equal '(1) (__ '(1 2 3)))
;;      (equal '((:x :y)) (__ '((:x :y) (:z) :a))))
;;   keep-first)  ; CODE TO BE WRITTEN

;; PROVIDE CODE
;; (defun keep-first (lst)
;;   (list (car lst)))

;; RUN TESTS
;; (test-keep-first-element)

;;;; full package name :io.github.heitorchang.four-cl

;; now in packages.lisp
;; (defpackage :pcl.unit-test
;;  (:use :common-lisp)
;;  (:export :__  ; placeholder for desired code
;;           :deftest))

(in-package :pcl.unit-test)

;;;; From Practical Common Lisp by Peter Seibel
;;;; gigamonkeys.com
;;;; Ch. 9

(defvar *test-name* nil)

;;; from Ch. 8
(defmacro pcl-with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(defmacro pcl-original-deftest (name parameters &body body)
  `(defun ,name ,parameters
     (let ((*test-name* (append *test-name* (list ',name))))
       ,@body)))

(defmacro check (&body forms)
  `(combine-results
    ,@(loop for f in forms collect `(report-result ,f ',f))))

(defmacro combine-results (&body forms)
  (pcl-with-gensyms (result)
                    `(let ((,result t))
                       ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
                       ,result)))

(defun report-result (result form)
  ;; (format t "~:[*** FAIL~;Pass~]: ~a: ~a~%" result *test-name* form)
  (format t "~:[*** FAIL~;Pass~]: ~a~%" result form)
  result)

;;;; custom functions for replacing the blank in unit tests
(defun my-subst (form old &rest new)
  (when form
    (if (equal (car form) old)
        (append new
                (apply #'my-subst (cdr form) old new))
        (if (listp (car form))
            (cons (apply #'my-subst (car form) old new)
                  (apply #'my-subst (cdr form) old new))
            (cons (car form)
                  (apply #'my-subst (cdr form) old new))))))

(defmacro replace-blank (form &rest replacements)
  (apply #'my-subst form '__ replacements))

;;;; compact syntax for multiple tests
(defmacro deftest (name tests &rest solution)
  `(replace-blank
    (pcl-original-deftest ,name ()
      (check
       ,@tests))
    ,@solution))
