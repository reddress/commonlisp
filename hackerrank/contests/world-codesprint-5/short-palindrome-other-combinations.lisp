(defun pick-short-string (str indices)
  (mapcar #'(lambda (i) (char str i)) indices))

(defun is-short-palindrome (char-list)
  (and (char= (first char-list) (fourth char-list))
       (char= (second char-list) (third char-list))))

(defun take-mod (n)
  (mod n (+ (expt 10 9) 7)))

(defun combinations (lst n)
  (cond ((= n 0) '(()))
        ((null lst) '())
        (t (append (mapcar #'(lambda (y) (cons (car lst) y))
                           (combinations (cdr lst) (- n 1)))
                   (combinations (cdr lst) n)))))

(defun range (n)
  (loop for i from 0 to (- n 1) collecting i))

(defun solution (str-input)
  (let* ((str-len (length str-input))
         (choices (range str-len)))
    (take-mod
     (count t
            (mapcar
             #'(lambda (comb)
                 ;; (format t "~A~%" comb)
                 (is-short-palindrome (pick-short-string str-input comb)))
             (combinations choices 4))))))

(defun main ()
  (let ((str-input (read-line)))
    (format t "~A" (solution str-input))))

;; (main)
