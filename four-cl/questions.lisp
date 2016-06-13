;;;; full package name :io.github.heitorchang.four-cl

(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; https://www.4clojure.com/problem/1
;;;; Problems marked (*) were modified

;;;; load unit-test framework
(load "unit-test.lisp")

(defparameter __ nil)

;;; 1 Nothing but the Truth

(deftest test-1 ()
  (check
   (equal __ t)))

(setf __ t)
;; (test-1)  ; pass

;;; 2 Simple Math

(deftest test-2 ()
  (check
   (= (- 10 (* 2 3)) __)))

(setf __ 4)
;; (test-2)  ; pass
        
;;; 3 Intro to Strings

(deftest test-3 ()
  (check
   (equal __ (string-upcase "hello world"))))

(setf __ "HELLO WORLD")
;; (test-3)  ; pass

;;; 4 Intro to Lists

(replace-blank
 (deftest test-4 ()
   (check
    (equal (list __) '(:a :b :c))))

 :a :b :c)

;; (test-4)  ; pass

;;; 5* conj -> cons

(replace-blank
 (deftest test-5 ()
   (check
    (equal __ (cons 1 '(2 3 4)))
    (equal __ (cons 1 (cons 2 '(3 4)))
