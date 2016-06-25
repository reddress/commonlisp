(defun read-space-sep-list ()
  (read-from-string (concatenate 'string "(" (read-line) ")")))

(let ((cyl-heights (read-line))
      (stack-1 (read-space-sep-list))
      (stack-2 (read-space-sep-list))
      (stack-3 (read-space-sep-list)))
  (format t "~a"
          (solve (list stack-1 stack-2 stack-3))))

(defun height (stack)
  (reduce #'+ stack))

(defun highest (stacks)
  (let ((highest-stack-index 0)
        (max-height (height (nth 0 stacks))))
    (dotimes (i (length stacks))
      (let ((cur-height (height (nth i stacks))))
        (when (> cur-height max-height)
          (setf highest-stack-index i)
          (setf max-height cur-height))))
    highest-stack-index))

(defun heights-equalp (stacks)
  (apply #'= (mapcar #'height stacks)))

(defun pop-highest (stacks)
  (let ((highest-index (highest stacks))
        (result '()))
    (dotimes (i (length stacks))
      (if (= i highest-index)
          (push (cdr (nth i stacks)) result)
          (push (nth i stacks) result)))
    result))
      

(defun solve (stacks)
  (if (heights-equalp stacks)
      (height (car stacks))
      (solve (pop-highest stacks))))
