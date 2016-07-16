(defparameter *memo* (make-hash-table))

(defun fibonacci (n)
  (let ((memo-value (gethash n *memo*)))
    (if memo-value
        memo-value
        (fibonacci-helper n 0 1 0))))

(defun fibonacci-helper (n i a b)
  (if (= n i)
      (progn
        (setf (gethash n *memo*) (mod b (+ (expt 10 8) 7)))
        (mod b (+ (expt 10 8) 7)))
      (fibonacci-helper n (+ i 1) (+ a b) a)))
