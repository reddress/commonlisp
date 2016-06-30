(defun read-list ()
  ;; read INPUT-STREAM EOF-ERROR-P (set to nil to avoid default error
   (let ((n (read *standard-input* nil)))  
    (if (null n)
        '()
        (cons n (read-list)))))

(defun process-lines ()
  (let ((line (read-line *standard-input* nil)))
    (when line
      (format t "...")
      (process-lines))))

(defun print-list-one-per-line (lst)
  (format t "~{~d~%~}" lst))

(defun print-list-in-one-line (lst)
  (format t "~a" (car lst))
  (when (cdr lst)
    (format t " ")
    (print-list-in-one-line (cdr lst)))
  
(defun read-space-sep-ints ()
  (read-from-string (concatenate 'string "(" (read-line) ")")))

(defun read-space-sep-strings ()
  (split #\Space (string-trim '(#\Newline) (read-line))))

(defun str-to-list (str)
  (read-from-string (concatenate 'string "(" str ")")))
