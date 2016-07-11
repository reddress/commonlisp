;;;; TODO names to be added
;; mapc
;; mapcan
;; mappend
;; member ;; predicate to determine if an element is in list
;; case

(in-package :hc)

;; Map alternate names to defined names
(defparameter *cat-aliases*
  '(list lists
    cons conses
    fileio file-io
    function functions
    global globals
    hashtable hash-tables
    hash-table hash-tables
    hashtables hash-tables
    number numbers
    object objects
    plist plists
    predicate predicates
    string strings
    type types
    vector vectors
    variable variables))

(defparameter *fun-db* (make-hash-table)
  "Storage for function reference")
(defparameter *cat-db* (make-hash-table)
  "Storage for category reference")

(defun combine-signature-and-doc (signature doc)
  (format nil "~a~%~%~a~%" signature (format nil doc)))

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
            (setf (gethash category-name *cat-db*) (list fun-signature)))))
    fun-name))

;;; retrieving documentation
(defun fun (&optional fun-name)
  (if fun-name
      (let ((ref-data (gethash fun-name *fun-db*)))
        (if (null ref-data)
            (format t "~%Nothing available.~%~%")
            (format t "~%~A~%" ref-data))
        fun-name)
      (progn
        (format t "~%Call (fun 'NAME) or (doc 'NAME) with one of: ~%~%")
        (dolist (fun (sort (loop for k being the hash-keys in *fun-db* collecting k) #'string<))
          (format t "~A  " fun))
        (format t "~%~%"))))

(defun doc (&optional name)
  (fun name))

(defun cat (&optional cat-name-input)
  (if cat-name-input
      (let* ((get-hash-value (getf *cat-aliases* cat-name-input))
             (cat-name
              (if get-hash-value
                  get-hash-value
                  cat-name-input))
             (cat-data (gethash cat-name *cat-db*)))
        (if (null cat-data)
            (format t "~%Nothing available.~%~%")
            (format t "~%~{~A~%~}~%" (reverse cat-data))))
      (progn
        (format t "~%Call (cat 'CAT-NAME) with one of: ~%~%")
        (dolist (cat (sort (loop for k being the hash-keys in *cat-db* collecting k) #'string<))
          (format t "~A~%" cat))
        (format t "~%"))))

;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function definitions
;; (add-fun FUN-NAME SIGNATURE LIST-OF-CATEGORIES DOC-STRING)
;;
;; Add example calls in DOC-STRING
;;
;; (add-fun 'first "(first LST)" '(lists)
;;  "(first '(1 2 3)) => 1
;;   Get first element.~%~%Like car.")
;;
;; Template:
;; (add-fun
;;  '       ; FUN-NAME
;;  ""      ; SIGNATURE
;;  '()     ; LIST-OF-CATEGORIES
;;  "EXAMPLE CALL(S)~%
;;   REMAINING DOCUMENTATION")

;;;;;;
;;;; A

(add-fun
 'add-fun
 "(add-fun FUN-NAME SIGNATURE LIST-OF-CATEGORIES DOC-STRING)"
 '(doc hc-lib)
 "(add-fun 'add-fun \"(add-fun NAME SIGNATURE CAT-LIST DOC-STR)\"
   '(doc hc-lib)
   \"Associates the DOC-STRING with FUN-NAME and given CATEGORIES\")~%
Associates the DOC-STRING with FUN-NAME and given CATEGORIES")

(add-fun
 'apply
 "(apply FUNCTION &rest ARGS+)"
 '(functional)
 "(apply #'+ '(1 2 3)) => 6
(apply #'+ 1 2 3 '(4 5)) => 15
(apply (lambda (x y z) (* x y z)) '(3 4 5)) => 60~%
Applies FUNCTION to ARGS.")

(add-fun
 'apropos
 "(apropos NAME-OR-PART)"
 '(doc)
 "(apropos 'subst) => NSUBST  SUBST  SUBST-IF  ...  SUBSTR
(apropos \"subst\") => NSUBST  SUBST  SUBST-IF  ...  SUBSTR~%
Prints the name of objects and functions matching given NAME-OR-PART")

(add-fun
 'atom
 "(atom OBJECT)"
 '(predicates objects)
 "(atom 's) => T
(atom (cons 1 2)) => NIL
(atom nil) => T~%
Returns true if OBJECT is of type ATOM. The opposite of CONSP.~%
NIL is both an atom and a list.~%
See also: CONSP")

;;;; B

;;;; C

(add-fun
 'coerce
 "(coerce OBJECT RESULT-TYPE)"
 '(lists strings)
 "(coerce \"abc\" 'list) => (#\a #\b #\c)
(coerce '(#\\o #\\k) 'string) => \"ok\"~%
Returns an object of RESULT-TYPE with contents of original OBJECT.")

(add-fun
 'concatenate
 "(concatenate RESULT-TYPE &rest SEQUENCES)"
 '(strings lists)
 "(concatenate 'string \"Hello\" \" \" \"all\") => \"Hello all\"
(concatenate 'list \"abc\" '(d e f) #(1 2 3))
  => (#\a #\b #\c D E F 1 2 3)~%
Returns a sequence of RESULT-TYPE, containing elements of SEQUENCES.")

(add-fun
 'cond
 "(cond CLAUSE*)"
 '(conditionals)
 "(cond ((= a 1) (setf a 2))
      ((= a 2)
       (print a)
       (print \"two\"))
      (t \"No matches.\"))~%
CLAUSEs are evaluated in order until its test is true.
The associated forms are evaluated in order as an implicit progn.")

(add-fun
 'consp
 "(consp OBJECT)"
 '(conses lists predicates)
 "(consp (cons 1 2)) => T
(consp '(1 2 3)) => T~%
(consp nil) => NIL
(consp ()) => NIL
(consp '()) => NIL~%
(consp (cons nil nil)) => T
(consp '(())) => T~%
Returns true if OBJECT is of type CONS. Note that NIL is not a CONS.
NIL is both an atom and a list.~%
The opposite of ATOM.~%
See also: LISTP, ATOM")

;;;; D

(add-fun
 'do
 "(do (VAR-FORM*) (END-TEST RESULT-FORM*) DECLARATION* STATEMENT*)"
 '(loops controls)
"VAR-FORM is (VAR INIT-FORM STEP-FORM)
When TEST-FORM is true, RESULT-FORMs are evaluated.
A DECLARATION is a DECLARE expression, and they are not evaluated.
STATEMENTs are evaluated at each iteration.~%
(do ((a 0 (+ a 1))
     (b 12 (- b 1)))
    ((> a b) a)
  (format t \"a: ~~a~~%\" a)) => (prints a from 0 to 6 and returns 7)~%
A general purpose loop that initializes variables and updates them
in each iteration. Loop ends when the test returns true.")

;;;; E

(add-fun
 'elt
 "(elt SEQUENCE INDEX)"
 '(sequences lists)
 "(elt \"abc\" 2) => #\c
(elt '(0 10 20 30) 2) => 20~%
Returns the element of SEQUENCE at given INDEX. 0 is the first element.
May be used with SETF.")

(add-fun
 'eq
 "(eq X Y)"
 '(predicates)
 "(eq #c(3 -4) #c(3 -4)) => NIL in CLISP
(eq 123 123) => T
(eq 100000000000000000 100000000000000000) => NIL~%
True if X and Y are the same, identical object. Implementations may
make copies of integers, so results may be T or NIL.")

(add-fun
 'eql
 "(eql X Y)"
 '(predicates)
 "(eql 3 3.0) => NIL
(eql (cons 'a 'b) (cons 'a 'b)) => NIL
(eql \"ab\" \"ab\") => NIL
(eql #\A #\A) => T
(eql 3 3) => T~%
True if X and Y are EQ (are the same, identical object),
are the same type of numbers with equal values, or
are the same characters.~%
If the implementation supports negative zeros as distinct from positive
zero, (eql 0.0 -0.0) is NIL")

(add-fun
 'equal
 "(equal X Y)"
 '(predicates)
 "(equal 3 3) => T
(equal 3 3.0) => NIL
(equal \"Abc\" \"Abc\") => T
(equal (cons 'a 'b) (cons 'a 'b)) => T~%
True if X and Y are structurally similar. Conses are compared
recursively. Strings and bit vectors are compared element-by-element.
Pathnames are compared by components (such as host and device). Case
sensitivity is implementation-dependent. All other objects are equal
only if they are EQ.")
       
;;;; F

(add-fun
 'first
 "(first LST)"
 '(lists)
 "(first '(1 2 3)) => 1 ~%
Returns the first element of LST.")

(add-fun
 'format
 "(format DESTINATION CONTROL-STRING &rest ARGS)"
 '(strings)
 "(format t \"~~A~~%\" (+ 1 2)) => outputs 3 to *standard-output*
(format nil \"~~S\" \"Hello\") => returns \"\\\"Hello\\\"\"~%
If DESTINATION is t, outputs formatted string to *standard-output*.
If DESTINATION is nil, a string is returned by the call to FORMAT.~%
  ~~A is the 'aesthetic' directive.
  ~~S generates output that can be read back with READ")

;;;; G

(add-fun
 'gethash
 "(gethash KEY HASH-TABLE)"
 '(hash-tables)
 "To set:
(setf (gethash KEY HASH-TABLE) VALUE)")

;;;; H

;;;; I

;;;; J

;;;; K

;;;; L

(add-fun
 'listp
 "(listp OBJECT)"
 '(lists predicates)
 "(listp nil) => T
(listp (cons 1 2)) => T
(listp t) => NIL~%
Returns true for any kind of list, including (), NIL.~%
NIL is both an atom and a list.~%
See also: CONSP")

;;;; M

(add-fun
 'make-hash-table
 "(make-hash-table &key TEST SIZE REHASH-SIZE REHASH-THRESHOLD)"
 '(hash-tables)
 "Creates a new hashtable. TEST determines how the keys are compared.
SIZE is a hint about how much initial space to allocate.")

;;;; N

(add-fun
 'nth
 "(nth N LST)"
 '(lists)
 "(nth 1 '(a b c)) => b~%
Returns the nth element of LST, where 0 is the first element's index.
May be used with SETF.~%
Note: argument order is the opposite of (ELT SEQUENCE INDEX)")

(add-fun
 'numberp
 "(numberp OBJECT)"
 '(numbers predicates)
 "(numberp 3) => T~%
Checks if the type of OBJECT is a number~%
See also: TYPE-OF")

;;;; O

;;;; P

(add-fun
 'push
 "(push ITEM PLACE)"
 '(lists)
 "(defparameter *lst* '())
(push 1 *lst*) => (1), *lst* => (1)~%
PUSH prepends ITEM to the list stored in PLACE.
Cannot be used with literal lists.")

;;;; Q

;;;; R

(add-fun
 'remove-if-not
 "(remove-if-not TEST SEQUENCE &key FROM-END START END COUNT KEY)"
 '(lists functional)
 "(remove-if-not #'oddp '(1 2 3 4 5 6)) => (1 3 5)~%
Removes elements not matching TEST. Behaves like FILTER.")

(add-fun
 'read
 "(read &optional INPUT-STREAM EOF-ERROR-P EOF-VALUE RECURSIVE-P)"
 '(io file-io)
 "(read *standard-input* nil)~%
Parses the printed representation of an object from INPUT-STREAM.
If EOF-ERROR-P is nil, EOF-VALUE will be returned instead of causing
an error.")

(add-fun
 'read-line
 "(read-line &optional INPUT-STREAM EOF-ERROR-P EOF-VALUE RECURSIVE-P)"
 '(io file-io)
 "Reads from INPUT-STREAM a line of text terminated by a newline or EOF.
If EOF-ERROR-P is nil, EOF-VALUE will be returned instead of causing
an error.")

;;;; S

(add-fun
 'setf
 "(setf PLACE NEW-VALUE PLACE-2 NEW-VALUE-2 ...)"
 '(variables)
 "(setf (car x) 'a)
Changes the value of PLACE to be NEW-VALUE. It is like saying,
'See to it that PLACE evaluates to NEW-VALUE.'
Pairs given to setf are processed sequentially.")

(add-fun
 'sort
 "(sort SEQUENCE PREDICATE &key KEY)"
 '(lists functional)
 "(sort '(3 5 2 1 9 4 6) #'<) => (1 2 3 4 5 6 9)
(sort '((7 6) (4 3) (6 5)) #'> :key #'car) => ((7 6) (6 5) (4 3))~%
Destructively sort SEQUENCE according to PREDICATE.~%
The argument to the KEY function is the SEQUENCE element.
The return value of KEY becomes the argument to PREDICATE.~%
Consider: STABLE-SORT guarantees stability.")

(add-fun
 'string-trim
 "(string-trim CHARACTER-SEQUENCE STRING)"
 '(strings)
 "Returns a substring of STRING, with all characters from
CHARACTER-SEQUENCE stripped off the beginning and end.~%
Consider: STRING-LEFT-TRIM, STRING-RIGHT-TRIM")

(add-fun
 'subseq
 "(subseq SEQUENCE START &optional END)"
 '(lists strings)
 "(subseq \"012345\" 3 5) => \"34\"
(subseq '(0 1 2 3 4) 1 3) => (1 2)~%
Creates a sequence that is a copy of the subsequence bounded by
START and END. The value at index START is included, but excludes END.~%
Consider: (setf (subseq SEQUENCE START &optional END) NEW-SUBSEQUENCE)
will replace at most the number of elements in the given subseq with
elements from NEW-SUBSEQUENCE.")

;;;; T

(add-fun
 'type-of
 "(type-of OBJECT)"
 '(types)
 "(type-of 200) => INTEGER
(type-of #'type-of) => COMPILED-FUNCTION~%
Returns OBJECT's type specifier")

;;;; U

;;;; V

;;;; W

;;;; X

;;;; Y

;;;; Z

(add-fun
 'zerop
 "(zerop OBJECT)"
 '(numbers predicates)
 "(zerop 3) => NIL~%
Returns T if OBJECT is 0")
