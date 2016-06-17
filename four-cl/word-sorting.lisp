;;;; Number and Problem description
;;;; 70 Word Sorting

;;;; using CLISP
(if (string= "heitor-asus" (subseq (machine-instance) 0 11))  ; ubuntu
    (ext:cd "/home/heitor/commonlisp/lib/")
    ;;;; else, in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\lib\\"))

;;;; load unit-test framework
(load "pcl-unit-test.lisp")

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp :pcl.unit-test))
(in-package :four-cl)

;;;; __ gets replaced by SOLUTION
;;
;; (deftest PROBLEM-NAME
;;     ((TEST)
;;      (equal (__ n) m)  ; example
;;      ...
;;      (TEST)
;;      (TEST)*)
;;   SOLUTION)

;; Run tests
;; (PROBLEM-NAME)
     
;;;; UPDATE file problem-list.txt after solving

(deftest test-word-sorting
    ((equal (__ "Have a nice day.")
            '("a" "day" "Have" "nice"))
     (equal (__ "Clojure is a fun language!")
            '("a" "Clojure" "fun" "is" "language"))
     (equal (__ "Fools fall for foolish follies.")
            '("fall" "follies" "foolish" "Fools" "for")))
  my-sort-words)

;;; http://cl-cookbook.sourceforge.net/strings.html
(defun split-by-one-space (string)
    "Returns a list of substrings of string
divided by ONE space each.
Note: Two consecutive spaces will be seen as
if there were an empty string between them."
    (loop for i = 0 then (1+ j)
          as j = (position #\Space string :start i)
          collect (subseq string i j)
       while j))

(defun keep-alpha-only (word)
  (coerce (remove-if-not #'alpha-char-p (coerce word 'list)) 'string))

(defun my-sort-words (sentence)
  (sort
   (mapcar #'keep-alpha-only (split-by-one-space sentence))
   #'string-lessp))
    
