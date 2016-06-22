(in-package :hc)

(deftest test-filter
    ((equal (filter-array 3 '(10 9 8 2 7 5 1 3 0)) '(2 1 0))))

(defun filter-array (upper-limit lst)
  (when lst
    (let ((head (car lst)))
      (if (< head upper-limit)
          (cons head (filter-array upper-limit (cdr lst)))
          (filter-array upper-limit (cdr lst))))))

(defun read-list ()
  (let ((n (read *standard-input* nil)))
    (if (null n)
        '()
        (cons n (read-list)))))
    
(defun print-list (lst)
  (format t "~{~d~%~}" lst))
