(defun pick-short-string (str indices)
  (mapcar #'(lambda (i) (char str i)) indices))

(defun is-short-palindrome (char-list)
  (and (char= (first char-list) (fourth char-list))
       (char= (second char-list) (third char-list))))

(defun take-mod (n)
  (mod n (+ (expt 10 9) 7)))

(defun grow (branches new-leaves)
  (if (null branches)
      '()
      (append (add-leaves (car branches) new-leaves) (grow (cdr branches) new-leaves))))

(defun add-leaves (branch leaves)
  (if (null leaves)
      '()
      (if (not (member (car leaves) branch))
          (cons (cons (car leaves) branch) (add-leaves branch (cdr leaves)))
          (add-leaves branch (cdr leaves)))))

(defun permutation-tree (choices levels)
  (if (<= levels 1)
      (add-leaves '() choices)
      (grow (permutation-tree choices (- levels 1)) choices)))

(defun combinations (choices n)
  (remove-duplicates 
   (mapcar #'(lambda (x) (sort x #'<)) (copy-tree (permutation-tree choices n)))
   :test #'equal))

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
