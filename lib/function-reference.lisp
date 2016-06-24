;;;; Call fn-ref with a symbol to print quick reference related to the
;;;; symbol

(in-package :hc)

(defparameter *ref-db* (make-hash-table)
  "Storage for reference")

;; LIST
(setf (gethash 'list *ref-db*) "
LIST
")

;; STRING
(setf (gethash 'string *ref-db*) "
HASH STRING
")

;; GLOBALS
(setf (gethash 'globals *ref-db*) "
Global names should be surrounded by *, such as *my-database*
Global variables are dynamic (special).

(defvar *count* 0
  \"Widget count. Assigned a value only once (when it is undefined)\")

(defparameter *gap-tolerance* 0.001
  \"Tolerance in widget gaps. Always assigns value to the variable.\")
")

;; PLIST
(setf (gethash 'plist *ref-db*) "
create:   (list :a 1 :b 2 :c 3)
retrieve: (getf (list :a 1 :b 2 :c 3) :c)  => 3
add:      (setf (getf my-plist :d) 4)
")

(defun fn-cat ()
  (format t "~%")
  (dolist (cat (sort (loop for k being the hash-keys in *ref-db* collecting k) #'string<))
    (format t "~A~%" cat)))

(defun fn-ref (raw-category)
  ;; given a category with similar names, map to a single category
  ;; actual category is on the right
  (let* ((map '(lists list
                strings string
                global globals
                plists plist))
         (new-value (getf map raw-category))
         (category
          (if new-value
              new-value
              raw-category)) ; not found, use given input
         (ref-data (gethash category *ref-db*)))
    (if (null ref-data)
        (format t "~%Nothing available.")
        (format t "~A" ref-data))
    t))
