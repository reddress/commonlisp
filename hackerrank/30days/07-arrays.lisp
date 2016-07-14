(defun read-space-sep-list ()
  (read-from-string (concatenate 'string "(" (read-line) ")")))

(defun print-list (lst)
  (format t "~a" (car lst))
  (when (cdr lst)
    (format t " ")
    (print-list (cdr lst))))

(let ((num (read))
      (in (read-space-sep-list)))
    (print-list (nreverse in)))
