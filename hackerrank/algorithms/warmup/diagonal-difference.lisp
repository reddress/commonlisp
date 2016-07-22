(defparameter *m* '((11 2 4) (4 5 6) (10 8 -12)))

(defun mref (row col matrix)
  (nth col (nth row matrix)))

(defun diag-top-left (matrix)
  (let ((sum 0))
    (dotimes (i (length matrix))
      (incf sum (mref i i matrix)))
    sum))

(defun diag-top-right (matrix)
  (let ((sum 0)
        (rows (length matrix)))
    (dotimes (i rows)
      (incf sum (mref i (- rows i 1) matrix)))
    sum))

(defun read-space-sep-ints ()
  (read-from-string (concatenate 'string "(" (read-line) ")")))

(defun main ()
  (let ((num-rows (read))
        (matrix '()))
    (dotimes (row num-rows)
      (push (read-space-sep-ints) matrix))
    (format t "~a" (abs (- (diag-top-left matrix) (diag-top-right matrix))))))

;; (main)
