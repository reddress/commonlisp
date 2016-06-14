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
 (deftest problem-square ()
   (check
    (= (__ 3) 9)))

 (lambda (x) (* x x)))

;; (problem-square)  ; victory

;;; % Reciprocal

(defun reciprocal (x)
  (/ 1 x))

(replace-blank
 (deftest problem-reciprocal ()
   (check
    (= (__ 1) 1)
    (equalp (__ 8) 0.125)))

 reciprocal)

;; (problem-reciprocal)  ; victory

;;; 1 Nothing but the Truth

(replace-blank
 (deftest problem-1 ()
   (check
    (equal __ t)))

 t)

;; (problem-1)  ; pass

;;; 2 Simple Math

(replace-blank
 (deftest problem-2 ()
   (check
    (= (- 10 (* 2 3)) __)))

 4)
        
;;; 3 Intro to Strings

(replace-blank
 (deftest problem-3 ()
   (check
    (equal __ (string-upcase "hello world"))))

 "HELLO WORLD")

;;; 4 Intro to Lists

(replace-blank
 (deftest problem-4 ()
   (check
    (equal (list __) '(:a :b :c))))

 :a :b :c)

;;; 5* conj (rewritten to: cons)

(replace-blank
 (deftest problem-5 ()
   (check
    (equal __ (cons 1 '(2 3 4)))
    (equal __ (cons 1 (cons 2 '(3 4))))))
 
 '(1 2 3 4))

;;; 6 Intro to Vectors

(replace-blank
 (deftest problem-6 ()
   (check
    (equalp __ (vector 1 2 3))))
 
 #(1 2 3))

;;; 7 Vectors: conj

(defparameter *problem-7-vector*
  (make-array 4
              :initial-contents '(1 2 3 nil)
              :fill-pointer 3
              :adjustable t))

(vector-push 4 *problem-7-vector*)  ; returns former value of fill-pointer

(defproblem problem-7
    ((equalp __ *problem-7-vector*))
  
  #(1 2 3 4))

;;; 8 Intro to Sets

;;; http://stackoverflow.com/questions/4975633/common-lisp-how-to-check-set-equality-ignoring-order
(defun my-set-equal (a b)
  (null (set-exclusive-or a b)))

(defproblem problem-8
    ((my-set-equal __ (union '(:a :b :c) '(:b :c :d))))
  '(:a :b :c :d))

;;; 9 Sets: conj

(defparameter *problem-9-set* '(1 4 3))

(defproblem problem-9
    ((my-set-equal '(1 2 3 4) (pushnew __ *problem-9-set*)))
  2)

(combine-problem-range 1 9)
