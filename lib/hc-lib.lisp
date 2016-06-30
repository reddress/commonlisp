;;;; auxiliary and extra functions, some from clojure

(in-package :hc)

(defun range (n)
  (loop for i from 0 to (- n 1) collecting i))

(defun repeat (n x)
  (loop for i from 1 to n collecting x))

;;; take the first n items of lst
(defun first-n (n lst)
  (reverse
   (nthcdr (- (length lst) n) (reverse lst))))

(defun partial (f &rest args)
  (lambda (&rest new-args)
    (apply f (append args new-args))))

(defun split (delim str)
  (let ((index-of-delim (position delim str)))
    (if (null index-of-delim)
        (list str)
        (cons (subseq str 0 index-of-delim)
              (split delim (subseq str (+ index-of-delim 1)))))))

;;; custom DEFSTRUCT
(defun prepend-to-symbol (pre sym)
  (intern (concatenate 'string pre "-" (symbol-name sym))))

(defun interleave-kw-sym (sym-lst)
  (when sym-lst
    (let ((head (car sym-lst)))
      (cons (intern (symbol-name head) "KEYWORD") (cons head (interleave-kw-sym (cdr sym-lst)))))))

;;; (defconstruct point x y)
(defmacro defconstruct (struct-name &rest fields)
  `(progn (defstruct ,struct-name ,@fields)
          (defun ,(prepend-to-symbol "CONSTRUCT" struct-name) (,@fields)
            (,(prepend-to-symbol "MAKE" struct-name)
              ,@(interleave-kw-sym fields)))))

;; (defmacro defconstruct-old (struct-name &rest fields)
  ;; http://stackoverflow.com/questions/5902847/how-do-i-apply-or-to-a-list-in-elisp/34946813#34946813
;;   (eval `(defstruct ,struct-name ,@fields))
  
;;   `(defun ,(prepend-to-symbol "CONSTRUCT" struct-name) (,@fields)
;;      (,(prepend-to-symbol "MAKE" struct-name)
;;             ,@(interleave-kw-sym fields))))

;;; (setf a (construct-point 3 4))
;;; (point-x a)

;; SLICE with negative indices
(let ((str "abcdef"))
  (deftest test-slice
      ((equal "ab" (slice str 0 2))
       (equal "f" (slice str -1))
       (equal "ef" (slice str -2))
       (equal "e" (slice str -2 -1)))))

(defun slice (sequence given-start &optional given-end)
  ;; "Calls SUBSEQ"
  (let* ((len (length sequence))
         (start (if (< given-start 0)
                    (+ len given-start)
                    given-start))
         (end (when given-end
                (if (< given-end 0)
                    (+ len given-end)
                    given-end))))
    (subseq sequence start end)))
