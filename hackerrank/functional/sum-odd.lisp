(defun read-list ()
  (let ((n (read *standard-input* nil)))  
    (if (null n)
        '()
        (cons n (read-list)))))

(defun sum-odd (lst)
  (reduce #'+ (remove-if-not #'oddp lst)))

(defun main ()
  (let ((input (read-list)))
    (format t "~a" (sum-odd input))))

;; (main)
