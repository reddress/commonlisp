;;;; full package name :io.github.heitorchang.four-cl

(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; using CLISP in Windows
(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\")

;;;; https://www.4clojure.com/problem/1
;;;; Problems marked (*) were modified

;;;; load unit-test framework
(load "unit-test.lisp")

;; (defparameter __ nil)  ; useful only for simple problems

;;;; Sample usage
;;; % Square

(replace-blank
 (deftest test-square ()
   (check
    (= (__ 3) 9)))

 (lambda (x) (* x x)))

;; (test-square)  ; victory
