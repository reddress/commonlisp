(defun plot (fn min max step)
  (loop for i from min to max by step do
       (loop repeat (funcall fn i) do (format t "*"))
       (format t "~%")))

(defun myseq (limit)
  (if (equal limit 0)
      ()
      (if (oddp limit)
	  (cons 1 (myseq (- limit 1)))
	  (cons 0 (myseq (- limit 1))))))

(defun add-odds (lst)
  (apply #'+ (mapcar #'* 
		    (reverse (myseq (length lst)))
		    lst)))
	  
(defun new-plot (x)
  
