(defun my-rev (lst)
  (my-rev-helper lst '()))

(defun my-rev-helper (lst result)
  (if (null lst)
      result
      (my-rev-helper (cdr lst) (cons (car lst) result))))

(defun read-list ()
  (let ((n (read *standard-input* nil)))
    (if (null n)
        '()
        (cons n (read-list)))))
    
(defun print-list (lst)
  (format t "~{~d~%~}" lst))

;;; typical usage 
;; (print-list (my-function (read-list)))
