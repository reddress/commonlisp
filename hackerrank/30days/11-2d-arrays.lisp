(defparameter *grid* (make-array '(6 6)))

(defun define-array ()
  (dotimes (row 6)
    (dotimes (col 6)
      (setf (aref *grid* row col) (read)))))

(defun sum-hourglass (top-left-row top-left-col)
  (if (or (> top-left-row 3) (> top-left-col 3))
      (error "SUM-HOURGLASS: Out of bounds")
      (progn
        (+ (aref *grid* top-left-row top-left-col)
           (aref *grid* top-left-row (+ top-left-col 1))
           (aref *grid* top-left-row (+ top-left-col 2))

           (aref *grid* (+ top-left-row 1) (+ top-left-col 1))

           (aref *grid* (+ top-left-row 2) top-left-col)
           (aref *grid* (+ top-left-row 2) (+ top-left-col 1))
           (aref *grid* (+ top-left-row 2) (+ top-left-col 2))))))

(defun main ()
  (define-array)
  (let ((max-sum nil))
    (dotimes (row 4)
      (dotimes (col 4)
        (let ((current-sum (sum-hourglass row col)))
          (if (null max-sum)
              (setf max-sum current-sum)
              (if (> current-sum max-sum)
                  (setf max-sum current-sum))))))
    (format t "~a" max-sum)))
