(declaim (optimize (speed 3) (debug 0) (safety 0)))

(defun accumulate (stack result)
  (if (null stack)
      result
      (accumulate (cdr stack) (cons (+ (car stack) (car result)) result))))

(defun sum-stack (stack)
  (accumulate (reverse stack) '(0)))

(defun solve (stack-1 stack-2 stack-3)
  (let ((sums-1 (sum-stack stack-1))
        (sums-2 (sum-stack stack-2))
        (sums-3 (sum-stack stack-3)))
    (dolist (a sums-1)
      (if (and (not (null (find a sums-2)))
               (not (null (find a sums-3))))
          (return-from solve a)))))
                    
;;; main

(defun read-space-sep-list ()
  (read-from-string (concatenate 'string "(" (read-line) ")")))

(defun main ()
  (let ((cyl-heights (read-line))
        (stack-1 (read-space-sep-list))
        (stack-2 (read-space-sep-list))
        (stack-3 (read-space-sep-list)))
    (format t "~a"
            (solve stack-1 stack-2 stack-3))))
