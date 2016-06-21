;;; p. 19
(defun make-adderb(n)
  (lambda (x &optional change)
    (if change
        (setf n x)
        (+ x n))))

(setf addx (make-adderb 1))
