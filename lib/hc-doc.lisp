;;;; TODO

(in-package :hc)

;; Map alternate names to defined names
(defparameter *cat-aliases*
  '(list lists
    string strings
    global globals
    plist plists
    function functions
    fileio file-io
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

;;;;;
;;; A

(add-fun
 'add-fun
 "(add-fun FUN-NAME SIGNATURE LIST-OF-CATEGORIES DOC-STRING)"
 '(doc hc-lib)
 "(add-fun 'add-fun \"(add-fun NAME SIGNATURE CAT-LIST DOC-STR)\"
   '(doc hc-lib)
   \"Associates the DOC-STRING with FUN-NAME and given CATEGORIES\")~%
Associates the DOC-STRING with FUN-NAME and given CATEGORIES")

;;; C

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

;;; D

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

;;; E

(add-fun
 'elt
 "(elt SEQUENCE INDEX)"
 '(sequences lists)
 "(elt \"abc\" 2) => #\c
(elt '(0 10 20 30) 2) => 20~%
Returns the element of SEQUENCE at given INDEX. 0 is the first element.
May be used with SETF.")
 
;;; F

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

;;; G

(add-fun
 'gethash
 "(gethash KEY HASH-TABLE)"
 '(hashtables)
 "To set:
(setf (gethash KEY HASH-TABLE) VALUE)")

;;; N

(add-fun
 'nth
 "(nth N LST)"
 '(lists)
 "(nth 1 '(a b c)) => b~%
Returns the nth element of LST, where 0 is the first element's index.
May be used with SETF.~%
Note: argument order is the opposite of (ELT SEQUENCE INDEX)")

;;; P

(add-fun
 'push
 "(push ITEM PLACE)"
 '(lists)
 "(defparameter *lst* '())
(push 1 *lst*) => (1), *lst* => (1)~%
PUSH prepends ITEM to the list stored in PLACE.
Cannot be used with literal lists.")

;;; R

(add-fun
 'remove-if-not
 "(remove-if-not TEST SEQUENCE &key FROM-END START END COUNT KEY)"
 '(lists functional)
 "(remove-if-not #'oddp '(1 2 3 4 5 6)) => (1 3 5)~%
Removes elements not matching TEST. Behaves like FILTER.")

;;; S

(add-fun
 'sort
 "(sort SEQUENCE PREDICATE &key KEY)"
 '(lists functional)
 "(sort '(3 5 2 1 9 4 6) #'<) => (1 2 3 4 5 6 9)
(sort '((7 6) (4 3) (6 5)) #'> :key #'car) => ((7 6) (6 5) (4 3))~%
Destructively sort SEQUENCE according to PREDICATE.~%
The argument to the KEY function is the SEQUENCE element.
The return value of KEY becomes the argument to PREDICATE.~%
Also: STABLE-SORT guarantees stability.")

(add-fun
 'subseq
 "(subseq SEQUENCE START &optional END)"
 '(lists strings)
 "(subseq \"012345\" 3 5) => \"34\"
(subseq '(0 1 2 3 4) 1 3) => (1 2)~%
Creates a sequence that is a copy of the subsequence bounded by
START and END. The value at index START is included, but excludes END.~%
Also: (setf (subseq SEQUENCE START &optional END) NEW-SUBSEQUENCE)
will replace at most the number of elements in the given subseq with
elements from NEW-SUBSEQUENCE.")
