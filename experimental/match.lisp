(make-package "MATCH")
(in-package "MATCH")

(defun variablep (sym)
  (if (symbolp sym)
      (eql (char (symbol-name sym) 0) #\?)
      nil))

(defun match-element (e1 e2)
  (cond ((eql e1 e2) t)
	((or (dont-care e1) (dont-care e2)) t)
	((variablep e1) (list e1 e2))
	((variablep e2) (list e2 e1))))

(defun dont-care (arg0)
  (if (symbolp arg0)
      (string= (symbol-name arg0) "?")
      nil))

(defun equal-lelt (l1 l2)
  (cond ((and (null l1) (null l2)) t)
	((eql (first l1) (first l2)) (equal-lelt (rest l1) (rest l2)))
	(t nil)))

(defun matchlelt (l1 l2)
  (cond ((and (null l1) (null l2)) t)
	((or (dont-care (first l1))
	     (dont-care (first l2))
	     (eql (first l1) (first l2)))
	 (matchlelt (rest l1) (rest l2)))
	(t nil)))