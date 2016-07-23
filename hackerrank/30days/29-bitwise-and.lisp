(defun and-values (n k)
  (let ((max 0))
    (dotimes (i (- n 1))
      (dotimes (j (- n i 1))
        (let ((a (+ i 1))
              (b (- n j)))
          (let ((and-value (logand a b)))
            ;; (format t "~a ~a ~a~%" a b (logand a b))
            (if (and (> and-value max) (< and-value k))
                (setf max and-value))))))
    max))


(defun read-space-sep-ints ()
  (read-from-string (concatenate 'string "(" (read-line) ")")))

(defun main ()
  (let ((num-cases (read)))
    (dotimes (i num-cases)
      (format t "~a~%" (apply #'and-values (read-space-sep-ints))))))