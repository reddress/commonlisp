(defun read-list ()
  (let ((n (read *standard-input* nil)))
    (if (null n)
        '()
        (cons n (read-list)))))    

(defun print-list-one-per-line (lst)
  (format t "~{~d~%~}" lst))

(defun print-list-in-one-line (lst)
  (format t "~a" (car lst))
  (when (cdr lst)
    (format t " ")
    (print-list-in-one-line (cdr lst)))
  
(defun read-space-sep-list ()
  (read-from-string (concatenate 'string "(" (read-line) ")")))

(defun str-to-list (str)
  (read-from-string (concatenate 'string "(" str ")")))
