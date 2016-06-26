;;; typical usage 
;; (print-list (my-function (read-list)))

(defun read-list ()
  (let ((n (read *standard-input* nil)))
    (if (null n)
        '()
        (cons n (read-list)))))    

(defun print-list (lst)
  (format t "~{~d~%~}" lst))

(defun read-space-sep-list ()
  (read-from-string (concatenate 'string "(" (read-line) ")")))

(defun str-to-list (str)
  (read-from-string (concatenate 'string "(" str ")")))
