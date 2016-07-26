(defun solution (candles)
  (let ((max-height (reduce #'max candles)))
    (format t "~A" (count max-height candles))))

(defun read-space-sep-ints ()
  (read-from-string (concatenate 'string "(" (read-line) ")")))

(let ((num-candles (read)))
  (let ((candles (read-space-sep-ints)))
    (solution candles)))
      
      
