(defun compute-fine (return-date due-date)
  (let ((return-year (third return-date))
        (return-month (second return-date))
        (return-day (first return-date))
        (due-year (third due-date))
        (due-month (second due-date))
        (due-day (first due-date)))
    
    (cond ((> return-year due-year)
           10000)
          ((and (> return-month due-month) (= return-year due-year))
           (* 500 (- return-month due-month)))
          ((and (> return-day due-day) (= return-year due-year) (= return-month due-month))
           (* 15 (- return-day due-day)))
          (t 0))))

(defun read-space-sep-ints ()
  (read-from-string (concatenate 'string "(" (read-line) ")")))

(defun main ()
  (let ((return-date (read-space-sep-ints))
        (due-date (read-space-sep-ints)))
    (format t "~A~%" (compute-fine return-date due-date))))

;; (main)

