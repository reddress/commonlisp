;;;; Threading macros -> and ->> in Common Lisp
;;;; http://web.bahcesehir.edu.tr/atabey_kaygun/Blog/threading-macros.html

(defpackage :hc-lib.threading
  (:use :common-lisp)
  (:export :->
           :->>))
(in-package :hc-lib.threading)

(defmacro ->> (x &rest forms)
  (dolist (f forms x)
    (setf x 
          (if (listp f)
              (append f (list x))
              (list f x)))))

(defmacro -> (x &rest forms)
  (dolist (f forms x)
    (setf x
          (if (listp f)
              (append (list (car f) x) (cdr f))
              (list f x)))))
