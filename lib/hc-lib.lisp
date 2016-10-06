;;;; auxiliary and extra functions, some from clojure

(in-package :hc)

;; Chinese zodiac user's guide
;; woo-woo

;; Given a year (past 20 Feb.), get the Chinese sign
;; (sign 1978)
;; ;; HORSE

;; Given a Chinese sign, get a list of years (past 20 Feb.)
;; (year 'horse)
;; ;; (1954 1966 1978 1990 2002)

;; Given a Chinese sign, get a list of ages (assuming the person completed
;;   his or her birthday)
;; (age 'horse)
;; ;; (14 26 38 50 62)

;; Given a Chinese sign, determine a person's age based on their Western
;;   sign
;; (chinese-age 'sheep)
;; ;; 25.6 37.6 AQUARIUS
;; ;; 25.5 37.5 PISCES
;; ;; ...
;; ;; 24.7 36.7 CAPRICORN

;; western zodiac
(defparameter western-signs
  '(aquarius pisces aries taurus gemini cancer leo virgo libra scorpio sagittarius capricorn))

;; reading down is younger
(defparameter western-zodiac (make-hash-table))
(setf (gethash 'aquarius    western-zodiac) '((1 20) (2 18)))
(setf (gethash 'pisces      western-zodiac) '((2 19) (3 20)))
(setf (gethash 'aries       western-zodiac) '((3 21) (4 19)))
(setf (gethash 'taurus      western-zodiac) '((4 20) (5 20)))
(setf (gethash 'gemini      western-zodiac) '((5 21) (6 20)))
(setf (gethash 'cancer      western-zodiac) '((6 21) (7 22)))
(setf (gethash 'leo         western-zodiac) '((7 23) (8 22)))
(setf (gethash 'virgo       western-zodiac) '((8 23) (9 22)))
(setf (gethash 'libra       western-zodiac) '((9 23) (10 22)))
(setf (gethash 'scorpio     western-zodiac) '((10 23) (11 21)))
(setf (gethash 'sagittarius western-zodiac) '((11 22) (12 21)))
(setf (gethash 'capricorn   western-zodiac) '((12 22) (12 31)))  ; hack to avoid adding a new year. Actual end date is (1 19)

;; chinese zodiac
(defparameter chinese-signs
  '(pig rat ox tiger rabbit dragon snake horse sheep monkey rooster dog))
;; 12/0  1   2   3      4      5     6     7     8      9      10    11 
;; set PIG to zeroth index (12 mod 12 is 0)

;; Method:
;; Given a sign, say SHEEP, find its position = 8
;; Add this position to a multiple of 12 : 12 24 36 48 60 72 84 96 108
;; Add 1900 to find the ENDPOINT in the Gregorian calendar of the Chinese yr
;; That is, the Year of the Sheep ENDED in 1980, and began in 1979.

(defparameter chinese-signs-normalized
  '(monkey rooster dog pig rat ox tiger rabbit dragon snake horse sheep))

;; reading down is younger
(defparameter chinese-zodiac (make-hash-table))
(setf (gethash 'rat     chinese-zodiac) 1)
(setf (gethash 'ox      chinese-zodiac) 2)
(setf (gethash 'tiger   chinese-zodiac) 3)
(setf (gethash 'rabbit  chinese-zodiac) 4)
(setf (gethash 'dragon  chinese-zodiac) 5)
(setf (gethash 'snake   chinese-zodiac) 6)
(setf (gethash 'horse   chinese-zodiac) 7)
(setf (gethash 'sheep   chinese-zodiac) 8)
(setf (gethash 'monkey  chinese-zodiac) 9)
(setf (gethash 'rooster chinese-zodiac) 10)
(setf (gethash 'dog     chinese-zodiac) 11)
(setf (gethash 'pig     chinese-zodiac) 12)

(defparameter chinese-offset 1971)

;; calendar age
(defun person-age-dmy (day month year)
  (let ((now (get-universal-time)))
    (/ (- now (encode-universal-time 0 0 12 day month year)) 60 60 24 365.25)))

(defun person-age (date)
  (let ((now (get-universal-time)))
    (/ (- now date) 60 60 24 365.25)))


;; date in between two given dates
(defun date-midpoint (a b)
  (multiple-value-bind (s m h d m y)
      (decode-universal-time (/ (+ a b) 2))
    ;; (format t "~a/~a/~a" y m d)))
    (encode-universal-time 0 0 12 d m y)))

(defun format-date (d)
  (multiple-value-bind (s m h d m y)
      (decode-universal-time d)
    (format t "~a/~a/~a" d m y)))

;; compute average date for given western sign
(defun average-western (sign-name &optional (year 2015))
  (let* ((begin-md (car (gethash sign-name western-zodiac)))
         (end-md (cadr (gethash sign-name western-zodiac)))
         (begin-date (encode-universal-time 0 0 12 (cadr begin-md) (car begin-md) year))
         (end-date (encode-universal-time 0 0 12 (cadr end-md) (car end-md) year)))
    (date-midpoint begin-date end-date)))

(defun age-of (western-sign-name chinese-sign-name)
  (let* ((year (+ chinese-offset (gethash chinese-sign-name chinese-zodiac)))
         (date (average-western western-sign-name year))
         (second-age (person-age date))
         (first-age (- second-age 12)))
    (format t "~,1f ~,1f ~a~%"  first-age second-age western-sign-name)))

;; zodiac shortcuts
(defun chinese-age (chinese-sign)
  (dolist (western-sign western-signs)
    (age-of western-sign chinese-sign)))

;; chinese-zodiac quiz

;; define a chinese year as the range where a sign is certain.
;; that is, avoid the gray area 21-jan to 19-feb.

(defun ask-for-chinese-sign (yr)  ;; yr is a debug variable, should be removed and then uncomment the 'random' line
  (setf *random-state* (make-random-state t))
  ;; (let* ((year (+ 1936 (random 80)))
  (let* ((year yr)
         (offset (- year chinese-offset))
         (order (mod offset 12))
         (sign (nth order chinese-signs)))
    (format t "What is the Sign of the year beginning 20 Feb. ~a? " year)
    (let ((answer (read)))
      (if (equal answer sign)
          (format t "Very good.~%")
          (format t "No, the sign is ~a.~%" sign)))))

(defun ask-for-years-of-sign (sign)
  (setf *random-state* (make-random-state t))
  (let* ((order (position sign chinese-signs))
         (mod-list '(monkey rooster dog pig rat ox tiger rabbit dragon snake horse sheep)))
    (format t "Give me a year (between 1970 and 1989) of the ~a. " sign)
    (let ((answer (read)))
      (if (equal (nth (mod answer 12) mod-list) sign)
          (format t "Very good.~%")
          (format t "No, ~a is a year of the ~a.~%" answer
                  (nth (mod (- (mod answer 12) 3) 12) chinese-signs))))))

(defun sign (yr)
  (nth (mod yr 12) chinese-signs-normalized))

(defun year (sign)
  (let ((base-year (+ chinese-offset (position sign chinese-signs))))
    (list (- base-year 24) (- base-year 12) base-year (+ base-year 12) (+ base-year 24))))

(defun years (sign)
  (year sign))

(defun person-age-by-year (birth-year)
  (multiple-value-bind (s m h d m y)
      (decode-universal-time (get-universal-time))
    (- y birth-year)))

(defun age (sign)
  (reverse (mapcar #'person-age-by-year (year sign))))
  
;; (defun range (n)
;;   (loop for i from 0 to (- n 1) collecting i))

;;; http://stackoverflow.com/questions/13937520/pythons-range-analog-in-common-lisp
(defun range (max &optional (min 0) (step 1))
  (if (not (equal min 0))
      ;; interpret second argument as max
      (loop for n from max below min by step
         collect n)
      ;; else consider first argument to be max
      (loop for n from min below max by step
         collect n)))

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
;;; (defparameter *pt* (construct-point 3 4))
;;; (point-x *pt*)  ;; get 
;;; (setf (point-x *pt*) 5)  ;; set
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

;;; http://cl-cookbook.sourceforge.net/strings.html
(defun replace-all (string part replacement &key (test #'char=))
  "Returns a new string in which all the occurences of the part 
is replaced with replacement."
  (with-output-to-string (out)
    (loop with part-length = (length part)
       for old-pos = 0 then (+ pos part-length)
       for pos = (search part string
                         :start2 old-pos
                         :test test)
       do (write-string string out
                        :start old-pos
                        :end (or pos (length string)))
       when pos do (write-string replacement out)
       while pos)))

;;; FOR loop replacement
;; for (i = start; i < end; i++) { ... }
(defmacro for++ (var-name start end &body body)
  `(do ((,var-name ,start (+ ,var-name 1)))
       ((>= ,var-name ,end) nil)
     ,@body))

;;;; Math

;;; log base b of x
(defun logb (base x)
  (/ (log x) (log base)))

;;; factorial
(defun ! (n)
  (fact-iter n 1))

(defun fact-iter (n result)
  (if (< n 2)
      result
      (fact-iter (- n 1) (* n result))))

;;; permutations of m items out of n
(defun npm (n m)
  (/ (! n) (! (- n m))))

;;; n choose m
(defun ncm (n m)
  ;; (/ (! n) (! (- n m)) (! m)))
  (/ (npm n m) (! m)))  ;; express in terms of npm, divided by the number of orders of the m items

;;; Randomizer

(defun make-random ()
  (setf *random-state* (make-random-state t)))
