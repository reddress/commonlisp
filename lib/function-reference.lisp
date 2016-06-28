;;;; OBSOLETE, update hc-doc instead

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

(defun add-fun (fun-name fun-doc)
  (let ((doc (gethash fun-name *fun-db*)))
    (if doc
        (format t "FUN-DB: Warning: Redefining ~a~%" fun-name))
    (setf (gethash fun-name *fun-db*) (format nil fun-doc))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BEGIN DOCS

;;; A
(add-fun 'add-fun "(add-fun FUN-NAME DOC)~%
(add-fun 'first \"Returns the first element of a list.\") ~%
Adds documentation for FUN-NAME to the *fun-db* DB hash-table.")

;;; C
(add-fun 'coerce "(coerce OBJECT RESULT-TYPE)~%
(coerce \"abc\" 'list) => (#\a #\b #\c)
(coerce '(#\o #\k) 'string) => \"ok\"~%
Returns an object of RESULT-TYPE with contents of original OBJECT.")

(add-fun 'concatenate "(concatenate RESULT-TYPE &rest SEQUENCES)~%
(concatenate 'string \"Hello\" \" \" \"all\") => \"Hello all\"
(concatenate 'list \"abc\" '(d e f) #(1 2 3))
  => (#\a #\b #\c D E F 1 2 3)~%
Returns a sequence of RESULT-TYPE, containing elements of SEQUENCES.")

(add-fun 'cond "(cond CLAUSES*)~%
(cond ((= a 1) (setf a 2))
      ((= a 2)
       (print a)
       (print \"two\"))
      (t \"No matches.\"))~%
CLAUSES are evaluated in order until its test is true.
The associated forms are evaluated in order as an implicit progn.")

;;; F
(add-fun 'first "(first LST)~%
(first '(1 2 3)) => 1 ~%
Returns the first element of LST.")

(add-fun 'format "(format DESTINATION CONTROL-STRING &rest ARGS)~%
(format t \"~~A~~%\" (+ 1 2)) => outputs 3 to *standard-output*
(format nil \"~~S\" \"Hello\") => returns \"\\\"ok\\\"\"~%
If DESTINATION is t, outputs formatted string to *standard-output*.
If DESTINATION is nil, a string is returned by the call to FORMAT.~%
  ~~A is the \"aesthetic\" directive.
  ~~S generates output that can be read back with READ")

;;; G
(add-fun 'gethash "(gethash KEY HASH-TABLE)~%
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
