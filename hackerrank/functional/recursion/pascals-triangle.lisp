(defun next-level (level)
  (let ((padded (cons 0 (append level '(0)))))
    (sum-consecutive padded)))

(defun sum-consecutive (lst)
  (if (null (cdr lst))
      '()
      (cons (+ (car lst) (cadr lst)) (sum-consecutive (cdr lst)))))

(defun pascals-triangle (n)
  (do ((level '(1) (next-level level))
       (i 0 (+ i 1)))
      ((= i n))
    (format t "~{~A ~}~%" level)))
