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

;; PCL Ch. 12
(mapcar (lambda (x) (* 2 x)) '(1 2 3)) => (2 4 6)
(mapcar #'+ '(1 2 3) '(100 200 300)) => (101 202 303)

;; the function passed to mapcan must return a list
(mapcan (lambda (x) (list x (* x 10))) '(1 2 3)) => (1 10 2 20 3 30)
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

(defconstant +my-constant+ 100
  \"A constant's name should be surrounded by + signs\")
")  ; end GLOBALS

;; LIST
(setf (gethash 'list *ref-db*) "
(equal list-a list-b)  ; eql will not work

(concatenate 'list #(1 2 3) '(4 5 6)) => (1 2 3 4 5 6)
(append '(1 2) '(3 4)) => (1 2 3 4)
(push 1 a) => (1)  ; needs (setf a '()) or similar
(sort '(\"foo\" \"bar\" \"can\") #'string<) => (\"BAR\" \"CAN\" \"FOO\")

(nth 2 '(a b c d e)) => c  ; lists only, for strings use (elt str n)
(nthcdr 2 '(a b c d e)) => (c d e)

(subseq lst start-index end-index)
(subseq '(0 1 2 3 4 5) 2) => (2 3 4 5)
(subseq '(0 1 2 3 4 5) 1 2) => (1)
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
(length \"abc\") => 3
(parse-integer str :junk-allowed t)
(concatenate 'string \"abc\" '(#\d #\e)) => \"abcde\"

(subseq \"foobarbaz\" 3 6) => \"bar\"
(elt \"abcde\" 2) => #\c
(position #\b \"foobar\") => 3

(split #\; \"a;b;c\") => (\"a\" \"b\" \"c\")  ; custom hc-lib function
(string-trim \" \" \"  abc \") => \"abc\"
       
(coerce \"abc\" 'list) => (#\a #\b #\c)
(coerce '(#\d #\e #\f) 'string)

Comparisons:
string=  string/=  string<=  string >=

Case-insensitive:
string-equal  string-not-equal  string-not-greaterp
")

;; VARIABLES
(setf (gethash 'variables *ref-db*) "
(incf x n) === (setf x (+ x n))  ; if n is omitted, it is 1
(decf x n) === (setf x (- x n))

(rotatef a b c)  ; assignment that rotates values left
")

;; VECTOR
(setf (gethash 'vector *ref-db*) "
Literal: #(1 2)
(make-array) is more general than (vector)
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
                vectors vector
                variable variables
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
