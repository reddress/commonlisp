;;;; TODO
;; sort
;; remove-if-not
;; subseq
;; push


;;;; Call FUN with a symbol to print quick reference related to the
;;;; symbol

;;;; Calling FUN with no symbol lists available function names.

(in-package :hc)

(defparameter *fun-db* (make-hash-table)
  "Storage for function reference")

(defparameter *cat-db* (make-hash-table)
  "Storage for category reference")

;; Map alternate names to defined names
(defparameter *cat-aliases* '(list lists
                              string strings
                              global globals
                              plist plists
                              function functions
                              fileio file-io
                              vector vectors
                              variable variables))

(defun combine-signature-and-doc (signature doc)
  (format nil "~a~%~%~a~%" signature (format nil doc)))

;; (add-fun 'first "(first LST)" '(lists) "Get first~%~%Similar to car")
(defun add-fun (fun-name fun-signature categories fun-doc)
  (let ((doc (gethash fun-name *fun-db*)))
    (if doc
        (format t "HC-DOC ADD-FUN: Warning: Redefining ~a~%" fun-name))
    (setf (gethash fun-name *fun-db*)
          (combine-signature-and-doc fun-signature fun-doc))
    (dolist (category-name categories)
      (let ((cat-fun-list (gethash category-name *cat-db*)))
        (if cat-fun-list
            (push fun-signature (gethash category-name *cat-db*))
            (setf (gethash category-name *cat-db*) (list fun-signature)))))))

;;; retrieving documentation

;;; testing
(add-fun 'first "(first LST)" '(lists) "Get first.~%~%Similar to car.")
(add-fun 'second "(second LST)" '(lists) "Get second")

(add-fun 'concatenate "(concatenate RESULT-TYPE &rest SEQUENCES)"
         '(strings lists) "Join given SEQUENCES")
