(defun read-list ()
  (let ((n (read *standard-input* nil)))
    (if (null n)
        '()
        (cons n (read-list)))))
    
(defun print-list (lst)
  (format t "~{~d~%~}" lst))

;;; typical usage 
;; (print-list (my-function (read-list)))
