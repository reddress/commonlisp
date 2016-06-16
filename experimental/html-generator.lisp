(if (string= "heitor-asus" (subseq (machine-instance) 0 11))  ; ubuntu
    (ext:cd "/home/heitor/commonlisp/lib/")
    ;;;; else, in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\lib\\"))

;;;; load unit-test framework
(load "pcl-unit-test.lisp")

(if (string= "heitor-asus" (subseq (machine-instance) 0 11))  ; ubuntu
    (ext:cd "/home/heitor/commonlisp/experimental/")
    ;;;; else, in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\experimental\\"))
;;;; full package name :io.github.heitorchang.four-cl
(defpackage :hc
  (:use :common-lisp :ext :pcl.unit-test))
(in-package :hc)

(setf sample-page
      '(html
        (head
         (meta :charset "utf-8")
         (title "My Homepage"))
        (body
         (

(deftest test-generator
    ((string= "<html></html>" (__ '(html)))
     (string= "<html><body></body></html>" (__ '(html (body))))
     (string= "<html><body>Hello</body></html>" (__ '(html (body "Hello")))))
  generate-html)

(deftest test-tag
    ((string= "<B>Bold</B>" (__ '(b "Bold"))))
  generate-tag)

(defun generate-html (lst)
  ())

(defun opening-tag (name)
  (let ((tag-string-name (string name)))
    (concatenate 'string "<" tag-string-name ">")))

(defun closing-tag (name)
  (let ((tag-string-name (string name)))
    (concatenate 'string "</" tag-string-name ">")))

(defun generate-tag (tag)
  (let ((tag-name (car tag))
        (tag-body (cadr tag)))
    (concatenate 'string
                 (opening-tag tag-name)
                 tag-body
                 (closing-tag tag-name))))
