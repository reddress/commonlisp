(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defun main ()
  (let ((ans (random 20)))
    (format t "~d" ans)
    (setq guess (parse-integer (prompt-read "Guess a number")))
    (cond ((equal guess ans) (format t "You guessed it"))
	  ((< (abs (- guess ans)) 3) (format t "Close"))
	  (t (format t "Not close")))))
    