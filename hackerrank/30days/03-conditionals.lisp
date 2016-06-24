(defun is-weirdp (in)
  (cond ((oddp in) "Weird")
        ((< in 5) "Not Weird")
        ((< in 21) "Weird")
        (t "Not Weird")))

(let ((in (read)))
  (format t "~A" (is-weirdp in)))
