
(defvar *stack-1* (vector 3 2 1 1 1))
(defvar *stack-2* (vector 4 3 2))
(defvar *stack-3* (vector 1 1 4 1))

(let ((stack-1 (vector 3 2 1 1 1))
      (stack-2 (vector 4 3 2))
      (stack-3 (vector 1 1 4 1)))
  (let ((height-1 (length stack-1))
        (height-2 (length stack-2))
        (height-3 (length stack-3)))
    (setf (fill-pointer stack-1) (length stack-1))
    (setf (fill-pointer stack-2) (length stack-2))
    (setf (fill-pointer stack-3) (length stack-3))
    (do ()
        ((= height-1 height-2 height-3) height-1)
      (if (and (> height-1 height-2)
               (> height-1 height-3))
          (decf height-1 (vector-pop stack-1))
          (if (> height-2 height-3)
              (decf height-2 (vector-pop stack-2))
              (decf height-3 (vector-pop stack-3)))))))

;;; main

  (defun read-space-sep-list ()
    (read-from-string (concatenate 'string "(vector " (read-line) ")")))

  (defun main ()
    (let ((cyl-heights (read-line))
          (stack-1 (read-space-sep-list))
          (stack-2 (read-space-sep-list))
          (stack-3 (read-space-sep-list)))
      (format t "~a"
              (solve stack-1 stack-2 stack-3))))
