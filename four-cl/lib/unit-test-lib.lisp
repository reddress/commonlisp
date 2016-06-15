;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl.unit-test
  (:use :common-lisp)
  (:export :__  ; placeholder for solution
           :deftest
           :check
           :combine-results
           :defproblem))

(in-package :four-cl.unit-test)

;;;; From Practical Common Lisp by Peter Seibel
;;;; gigamonkeys.com
;;;; Ch. 9

;;; from Ch. 8
(defmacro pcl-with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(defvar *test-name* nil)

(defmacro deftest (name parameters &body body)
  `(defun ,name ,parameters
     (let ((*test-name* (append *test-name* (list ',name))))
       ,@body)))

(defmacro check (&body forms)
  `(combine-results
    ,@(loop for f in forms collect `(report-result ,f ',f))))

(defmacro combine-results-original (&body forms)
  (pcl-with-gensyms (result)
                    `(let ((,result t))
                       ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
                       ,result)))

(defmacro combine-results (&body forms)
  (pcl-with-gensyms (result)
                    `(let ((,result t))
                       ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
                       ,result)))

(defun report-result (result form)
  ;; (format t "~:[*** FAIL~;Pass~]: ~a: ~a~%" result *test-name* form)
  (format t "~:[*** FAIL~;Pass~]: ~a~%" result form)
  result)

(defmacro fn-choose-message (f new-name)
  `(defun ,new-name ()
     (let ((result (funcall ,f)))
       (if result
           "All tests passed."
           "One or more tests failed."))))

;;;; usage

(deftest test-+ ()
  (check
   (= (+ 1 2) 3)
   ;; (= (+ 1 1) 11)
   (= (+ -1 -5) -6)))

(deftest test-* ()
  (check
   (= (* 1 0) 0)
   (= (* 2 3) 6)))

(deftest test-arithmetic ()
  (combine-results
   (test-+)
   (test-*)))

(deftest test-compare ()
  (check
   (> 1 0)))

(deftest test-all ()
  (combine-results
   (test-arithmetic)
   (test-compare)
   (check
    (= (- 1 1) 0))))

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

;;;; shorten an individual problem's tests
(defmacro defproblem (name tests &rest solution)
  `(replace-blank
    (deftest ,name ()
      (check
       ,@tests))
    ,@solution))

;;; copy of the above
(defmacro defproblem-single-test (name tests &rest solution)
  `(replace-blank
    (deftest ,name ()
      (check
       ,@tests))
    ,@solution))

;;; appends -TEST to symbol
(defun append-test (sym)
  (intern (concatenate 'string (string sym) "-TEST")))

;;; Wraps tests with a generated a human-readable overall result
;;; Does not work on nested tests
(defmacro defproblem-wrapper (name tests &rest solution)
  `(progn
     (defproblem-single-test ,(append-test name) ,tests ,@solution)
     (fn-choose-message #',(append-test name) ,name)))

;;;; combine a range of numbered tests into RANGE-TESTS

;; (deftest range-tests ()
;;   (combine-results
;;    (problem-1)
;;    (problem-2)
;;     ...
;;    (problem-6)))

(defun problem-symbol (n)
  (intern (concatenate 'string "PROBLEM-" (write-to-string n))))

(defun problem-range (start end)
  (loop for i from start to end collecting (list (problem-symbol i))))

(defmacro combine-problem-range (name start end)
  `(deftest ,name ()
     (combine-results
      ,@(problem-range start end))))

