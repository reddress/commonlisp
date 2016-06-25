(defun height (stack)
  (reduce #'+ stack))

(defun index-of-max-3 (a b c)
  (if (and (> a b) (> a c))
      1
      (if (> b c)
          2
          3)))

(defun solve (stack-1 stack-2 stack-3)
  (let* ((height-1 (height stack-1))
         (height-2 (height stack-2))
         (height-3 (height stack-3))
         (max-index (index-of-max-3 (height-1 height-2 height-3))))
    (unless (= height-1 height-2 height-3)
      (cond ((= max-index 1)
             (decf height-1 
                   
))    



;;; main

(defun read-space-sep-list ()
  (read-from-string (concatenate 'string "(" (read-line) ")")))

(defun main ()
  (let ((cyl-heights (read-line))
        (stack-1 (read-space-sep-list))
        (stack-2 (read-space-sep-list))
        (stack-3 (read-space-sep-list)))
    (format t "~a"
            (solve (list stack-1 stack-2 stack-3)))))
