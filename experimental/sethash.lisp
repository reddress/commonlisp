(defparameter *my-hash* (make-hash-table))

(setf (gethash 'a *my-hash*) '())

(let ((lst (gethash 'a *my-hash*)))
  (push lst 30))

;;  (setf lst '(20)))
