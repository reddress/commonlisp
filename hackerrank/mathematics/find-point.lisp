(defun parse-points ()
  (list (read) (read) (read) (read)))

(defun compute-sym-pt (coords)
  (let ((x1 (nth 0 coords))
        (x2 (nth 2 coords))
        (y1 (nth 1 coords))
        (y2 (nth 3 coords)))
    (let ((dx (- x2 x1))
          (dy (- y2 y1)))
      (format t "~a ~a~%" (+ x2 dx) (+ y2 dy)))))

(let ((tests (read)))
  (dotimes (i tests)
    (compute-sym-pt (parse-points))))
      
   
