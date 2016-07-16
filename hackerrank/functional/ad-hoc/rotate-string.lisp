(defun my-rotate-left (lst)
  (append (cdr lst) (list (car lst))))

(defun str-rotate (str)
  (coerce (my-rotate-left (coerce str 'list)) 'string))

(defun repeat-rotate (str)
  (let ((n (length str))
        (cur-string str))
    (dotimes (i n)
      (setf cur-string (str-rotate cur-string))
      (format t "~A " cur-string))))

