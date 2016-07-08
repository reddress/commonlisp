;;;; auxiliary and extra functions, some from clojure

(in-package :hc)

;;; shortcuts
(defun cd-viva ()
  (if (equal (subseq (machine-instance) 7 11) "asus")
      (ext:cd #P"/home/heitor/vivajs.github.io/tutorial/content/")
      (ext:cd #P"C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\vivajs.github.io\\tutorial\\content\\")))

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

;; Returns a function that accepts a list,
;; given a predicate to test each element.
;; Applies function accum-true to values where predicate is true
;; If accum-false is given, the function is applied to values
;; where predicate is false.
;; If accum-false is omitted, those values are not included
;; in the result. Use #'identity to keep the false values.

;; Example:
;;
;; (filter-transform
;;  '("john" "kenneth" "larry" "lawrence" "margaret")
;;  (lambda (s) (< (length s) 6))
;;  #'string-upcase
;;  #'identity)

(defun filter-transform (lst predicate accum-true &optional accum-false)
  (labels
      ((iter (lst result)
         (let ((head (car lst)))
           (if (null lst)
               (reverse result)
               (if (funcall predicate head)
                   (iter (cdr lst) (cons (funcall accum-true head) result))
                   (if accum-false
                       (iter (cdr lst) (cons (funcall accum-false head) result))
                       (iter (cdr lst) result)))))))
    (iter lst '())))

(defmacro pcl-with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))
