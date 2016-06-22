(defun f (n)
  (if (= n 0)
      '()
      (cons 1 (f (- n 1)))))
