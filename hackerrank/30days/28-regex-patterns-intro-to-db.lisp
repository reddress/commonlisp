(ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\hackerrank\\30days\\")

(defstruct user first-name email)

(defun split-by-space (str)
  (let ((index-of-delim (position #\Space str)))
    (if (null index-of-delim)
        (list str)
        (cons (subseq str 0 index-of-delim)
              (split-by-space (subseq str (+ index-of-delim 1)))))))

(defun get-first-name-if-gmail (line)
  (destructuring-bind (name email)
      (split-by-space line)
    (if (is-gmail email)
        name)))

(defun is-gmail (email)
  (search "@gmail" email :test #'equalp))

(defun main ()
  (let ((user-list '()))
    (with-open-file (in "28-email-list.txt")
      (let ((num-lines (read in)))
        (dotimes (i num-lines)
          (push (get-first-name-if-gmail (read-line in)) user-list))))
    (format t "~{~a~%~}" (remove-if #'null (sort user-list #'string<)))))

