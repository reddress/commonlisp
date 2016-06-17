;;; SBCL
;; (defun create-exe (filename)
;;   (sb-ext:save-lisp-and-die filename :toplevel #'main :executable t))

;;; CLISP
;;; needs DLLs from "full" folder
(defun create-exe (filename)
  (ext:saveinitmem filename :quiet t :init-function 'main :executable t :norc t)) 

(defun split-string (delimiter string)
  "Returns a list of substrings of string
divided by ONE delimiter character."
  (loop for i = 0 then (1+ j)
     as j = (position delimiter string :start i)
     collect (subseq string i j)
     while j))
