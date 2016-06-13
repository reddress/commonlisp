;;;; full package name :io.github.heitorchang.four-cl

(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

;;;; https://www.4clojure.com/problem/1
;;;; Problems marked (*) were modified

;;;; load unit-test framework
(load "unit-test.lisp")

(defparameter __ nil)

;;;; Sample usage
;;; % Square

(replace-blank
 (deftest test-square ()
   (check
    (= (__ 3) 9)))

 (lambda (x) (* x x)))

;; (test-square)  ; victory

;;; % Reciprocal

(defun reciprocal (x)
  (/ 1 x))

(replace-blank
 (deftest test-reciprocal ()
   (check
    (= (__ 1) 1)
    (equalp (__ 8) 0.125)))

 reciprocal)

;; (test-reciprocal)  ; victory

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
        
;;; 3 Intro to Strings

(deftest test-3 ()
  (check
   (equal __ (string-upcase "hello world"))))

(setf __ "HELLO WORLD")

;;; 4 Intro to Lists

(replace-blank
 (deftest test-4 ()
   (check
    (equal (list __) '(:a :b :c))))

 :a :b :c)

;;; 5* conj (rewritten to: cons)

(replace-blank
 (deftest test-5 ()
   (check
    (equal __ (cons 1 '(2 3 4)))
    (equal __ (cons 1 (cons 2 '(3 4))))))
 
 '(1 2 3 4))

;;; 6 Intro to Vectors

(replace-blank
 (deftest test-6 ()
   (check
    (equalp __ (vector 1 2 3))))
 
 #(1 2 3))

;;; 7
