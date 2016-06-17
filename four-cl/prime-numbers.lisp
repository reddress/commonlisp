;;;; Number and Problem description
;;;; 67 Prime Numbers

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

(deftest test-prime-numbers
    ((equal (__ 2) '(2 3))
     (equal (__ 5) '(2 3 5 7 11))
     (equal (car (last (__ 100))) 541))
  first-n-primes)

(defun is-prime (n)
  (dotimes (i (isqrt n))
    (let ((test-factor (+ i 2)))  ; really only need to go to sqrt(n)
      (if (= 0 (rem n test-factor))
          (return-from is-prime nil))))
  t)

;;; given n, find the next number greater than n that is prime
(defun next-prime (n)
  (let ((next-int (+ n 1)))
    (if (is-prime next-int)
        next-int
        (next-prime next-int))))

(defun first-n-primes (n)
  (reverse
   (first-n-primes-helper n)))

(defun first-n-primes-helper (n)
  (if (= 1 n)
      '(2)
      (let ((prev-lst (first-n-primes-helper (- n 1))))
        (cons (next-prime (car prev-lst)) prev-lst))))

(defun first-divisor (n)
  (dotimes (i (isqrt n))
    (let ((j (+ i 2)))
      (if (= 0 (rem n j))
          (return-from first-divisor j))))
  n)
  
(defun factor (n)
  (if (= n 1)
      '()
      (let ((divisor (first-divisor n)))
        (cons divisor (factor (/ n divisor)))))) 
