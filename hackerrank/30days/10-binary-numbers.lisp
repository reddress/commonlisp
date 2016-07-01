(defun binary-char-list (n)
  (coerce (format nil "~b" n) 'list))

(defun split-at-zero (lst result)
  (if (null lst)
      result
      (if (equal #\0 (car lst))
          (split-at-zero (cdr lst) (cons '() result))
          (split-at-zero (cdr lst) (cons (cons 1 (car result)) (cdr result))))))

(defun count-lengths (lst)
  (mapcar #'length lst))

(let ((n 15))
  (format t "~a"
          (apply #'max (count-lengths (split-at-zero (binary-char-list n) '(()))))))
