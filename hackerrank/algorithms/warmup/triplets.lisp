(defun compare-element (a b)
  (cond ((> a b) '(1 0))
        ((> b a) '(0 1))
        (t '(0 0))))
         
(defun compare-triplets (a b)
  (mapcar #'compare-element a b))

(defun read-space-sep-ints ()
  (read-from-string (concatenate 'string "(" (read-line) ")")))

(defun main ()
  (format t "~{~a ~}"
          (reduce #'(lambda (a b) (mapcar #'+ a b))
                  (compare-triplets (read-space-sep-ints) (read-space-sep-ints)))))

(main)
  
