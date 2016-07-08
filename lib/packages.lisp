;;; from Practical Common Lisp source code: Chapter09
(in-package :cl-user)

(defpackage :pcl.unit-test
  (:use :common-lisp)
  (:export :__
           :deftest))

(defpackage :com.gigamonkeys.macro-utilities
  (:use :common-lisp)
  (:export 
   :with-gensyms
   :with-gensymed-defuns
   :once-only
   :spliceable
   :ppme))

(defpackage :com.gigamonkeys.html
  (:use :common-lisp :com.gigamonkeys.macro-utilities)
  (:export :with-html-output
           :with-html-to-file
           :in-html-style
           :define-html-macro
           :define-css-macro
           :css
           :html
           :emit-css
           :emit-html
           :&attributes))

(defpackage :hc
  (:use :common-lisp
        :pcl.unit-test
        :com.gigamonkeys.html)
  (:import-from :ext :cd)
  (:export :doc
           :fun
           :cat))
