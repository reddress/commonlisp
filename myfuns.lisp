(defun my-reverse (lst)
  (labels ((rec (lst tsl)
	     (if (null lst) tsl
		 (rec (rest lst) (cons (first lst) tsl)))))
    (rec lst ())))