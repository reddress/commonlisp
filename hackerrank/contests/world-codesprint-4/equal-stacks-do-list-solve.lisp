(defun solve (stack-1 stack-2 stack-3)
  (let ((height-1 (reduce #'+ stack-1))
        (height-2 (reduce #'+ stack-2))
        (height-3 (reduce #'+ stack-3)))
    (do ()
        ((= height-1 height-2 height-3) height-1)
      (if (and (> height-1 height-2)
               (> height-1 height-3))
          (progn
            (decf height-1 (car stack-1))
            (setf stack-1 (cdr stack-1)))
          (if (> height-2 height-3)
              (progn
                (decf height-2 (car stack-2))
                (setf stack-2 (cdr stack-2)))
              (progn
                (decf height-3 (car stack-3))
                (setf stack-3 (cdr stack-3))))))))

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

;; (defun my-debug ()
;;   (solve '(3 2 1 1 1) '(4 3 2) '(1 1 4 1)))
