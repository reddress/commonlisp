(defun factorial (n)
    (if (= n 0)
        1
        (* n (factorial (- n 1)))))

(let ((x (read)))
     (format t "~a" (factorial x)))
