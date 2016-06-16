(defun exp-sequence (start factor elements)
  (nreverse
   (exp-sequence-helper factor (list start) elements)))

(defun exp-sequence-helper (factor result i)
  (if (<= i 1)
      result
      (exp-sequence-helper
       factor (cons (* (car result) factor) result) (- i 1))))

;;; create a time sequence of values starting with 1,
;;; compounded by growth, as a percent value (enter 8 for 8% growth)

(defun exp-growth (growth n)
  (exp-sequence 1 (+ 1 (/ growth 100.0)) n))
