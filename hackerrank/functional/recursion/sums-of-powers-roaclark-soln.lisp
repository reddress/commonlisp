(defun count-ways (goal pow min)
  (if (= goal 0)
      1
      (if (or (minusp goal) (< goal (expt min pow)))
          0
          (+ (count-ways goal pow (1+ min)) (count-ways (- goal (expt min pow)) pow (1+ min))))))

(format t "~d~%" (count-ways (read) (read) 1))
