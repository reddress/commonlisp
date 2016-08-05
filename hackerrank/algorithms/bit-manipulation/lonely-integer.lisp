(defun get-lonely-integer (sorted-lst)
  (if (null (cdr sorted-lst))
      (car sorted-lst)
      (if (not (= (car sorted-lst) (cadr sorted-lst)))
          (car sorted-lst)
          (get-lonely-integer (cddr sorted-lst)))))

(defun read-space-sep-ints ()
  (read-from-string (concatenate 'string "(" (read-line) ")")))

(let ((num-ints (read))
      (lst (read-space-sep-ints)))
  (get-lonely-integer (sort lst #'<)))
        
