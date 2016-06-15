(defun my-square ()
  (format t "Please enter a number: ")
  (let ((x (read)))
    (format t "The number ~S squared is ~S.~%"
	    x (* x x))))

(defun get-pay ()
  (format t "Enter hourly wage: ")
  (let ((hourly (read)))
    (format t "Enter number of hours: ")
    (let ((hours (read)))
      (format t "Gross pay: ~S" (* hourly hours)))))

(defun get-tree-data ()
  (with-open-file (stream "C:/lispdata/timber.dat")
    (let* ((tree-loc (read stream))
	   (tree-table (read stream))
	   (num-trees (read stream))
	   (something (read stream)))
      (format t "~&There are ~S trees on ~S."
	      num-trees tree-loc)
      (format t "~&They are: ~S" tree-table)
      (format t "~&Additional data: ~S" something))))

(defun save-tree-data (tree-loc tree-table num-trees)
  (with-open-file (stream "C:/lispdata/timber2.dat" :direction :output)
    (format stream "~S~%" tree-loc)
    (format stream "~S~%" tree-table)
    (format stream "~S~%" num-trees)))