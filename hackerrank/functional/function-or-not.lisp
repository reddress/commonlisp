(defun main ()
  (let ((test-cases (read)))
    (dotimes (test-num test-cases)
      (let ((num-pairs (read))
            (xs '()))
        (dotimes (pair-num num-pairs)
          (let ((x (read))
                (y (read)))
            (push x xs)))
        (format t "~A~%" 
                (if (= (length xs) (length (remove-duplicates xs)))
                    "YES"
                    "NO"))))))
            
