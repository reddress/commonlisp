;;;; Call FN-REF with a symbol to print quick reference related to the
;;;; symbol

;;;; FN-CAT lists available categories

(in-package :hc)

(defparameter *ref-db* (make-hash-table)
  "Storage for reference")

;; FILE-IO
(setf (gethash 'file-io *ref-db*) "
;; write  ; PCL Ch. 3
(with-open-file (out filename
                     :direction :output
                     :if-exists :supersede)
  (with-standard-io-syntax
    (print *db* out)))

;; read
(with-open-file (in filename)
  (with-standard-io-syntax
    (setf *db* (read in))))
")

;; FORMAT
(setf (gethash 'format *ref-db*) "
;; PCL Ch. 3
~a : aesthetic directive (human-readable)
~10t : pad with spaces to move to the 10th column
~{ ... ~} : loop through a list
~% : newline
")

;; FUNCTIONAL
(setf (gethash 'functional *ref-db*) "
(remove-if-not #'evenp '(1 2 3 4 5 6 7)) => (2 4 6)  ; same as filter

(funcall #'foo 1 2 3)
(apply #'plot var-1 var-2 var-list)
")

;; FUNCTIONS
(setf (gethash 'functions *ref-db*) "
;; Rest parameters  ; PCL Ch. 5
(defun my-fn (arg1 arg2 &rest values))  ; values becomes a list

;; Break
(defun foo (n)
  ...
  (return-from foo some-return-value))
")

;; GLOBALS
(setf (gethash 'globals *ref-db*) "
;; PCL Ch. 6
Global names should be surrounded by *, such as *my-database*
Global variables are dynamic (special).

(defvar *count* 0
  \"Widget count. Assigned a value only once (when it is undefined)\")

(defparameter *gap-tolerance* 0.001
  \"Tolerance in widget gaps. Always assigns value to the variable.\")
")  ; end GLOBALS

;; LIST
(setf (gethash 'list *ref-db*) "
(equal list-a list-b)  ; eql will not work
")

;; LOOP
(setf (gethash 'loop *ref-db*) "
(loop for ...)
")

;; PLIST
(setf (gethash 'plist *ref-db*) "
;; PCL Ch. 3
create:   (list :a 1 :b 2 :c 3)
retrieve: (getf (list :a 1 :b 2 :c 3) :c) => 3
add:      (setf (getf my-plist :d) 4)
")

;; STRING
(setf (gethash 'string *ref-db*) "
(parse-integer str :junk-allowed t)
")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BEGIN INTERFACE

(defun fn-cat ()
  (format t "~%")
  (dolist (cat (sort (loop for k being the hash-keys in *ref-db* collecting k) #'string<))
    (format t "~A~%" cat))
  t)

(defun fn-ref (raw-category)
  ;; given a category with similar names, map to a single category
  ;; actual category is on the right
  (let* ((map '(lists list
                strings string
                global globals
                plists plist
                function functions
                fileio file-io
                ))
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
