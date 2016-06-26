;;;; Call FUN with a symbol to print quick reference related to the
;;;; symbol

;;;; Calling FUN with no symbol lists available function names.

(in-package :hc)

(defparameter *fun-db* (make-hash-table)
  "Storage for function reference")

(defun add-fun (fun-name fun-doc)
  (let ((doc (gethash fun-name *fun-db*)))
    (if doc
        (format t "FUN-DB: Warning: Redefining ~a~%" fun-name))
    (setf (gethash fun-name *fun-db*) fun-doc)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BEGIN DOCS

;;; A
(add-fun 'add-fun "(add-fun FUN-NAME DOC)
(add-fun 'first \"Returns the first element of a list.\")

Adds documentation for FUN-NAME to the *fun-db* DB hash-table.")

;;; F
(add-fun 'first "(first LST)
(first '(1 2 3)) => 1

Returns the first element of LST.")

;;; G
(add-fun 'gethash "(gethash KEY HASH-TABLE)

To set:
(setf (gethash KEY HASH-TABLE) VALUE)")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BEGIN INTERFACE

(defun fun (&optional fun-name)
  (if fun-name
      (let ((ref-data (gethash fun-name *fun-db*)))
        (if (null ref-data)
            (format t "~%Nothing available.")
            (format t "~%~A~%~%" ref-data))
        fun-name)
      (progn
        (format t "~%Call (fun 'FUN-NAME) with one of: ~%~%")
        (dolist (fun (sort (loop for k being the hash-keys in *fun-db* collecting k) #'string<))
          (format t "~A  " fun)))))
