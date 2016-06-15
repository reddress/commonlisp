(defun my-find-null (lst)
  (let ((result nil))
    (dotimes (i (length lst))
      (setf result (or result (null (nth i lst)))))
    result))

(defun my-find-null-with-mapcar (lst)
  (labels ((my-or (a b) (or a b)))
    (reduce #'my-or (mapcar #'null lst))))
