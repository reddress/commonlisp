(defun read-list ()
  (let ((n (read *standard-input* nil)))
    (if (null n)
        '()
        (cons n (read-list)))))
    
(defun print-list (lst)
  (format t "~{~d~%~}" lst))

;;; typical usage 
;; (print-list (my-function (read-list)))

(defun main ()
  (let ((array-length (read))
        (array (read-list)))
    (format t "~a" (solve array))))
            
(defvar *test0* '(7 1 3 4 1 7))

(defun list-indices-of-same-n (lst)
  (let ((result '())
        (index 0))
    (dolist (n lst)
      (if (getf result n)
          (push index (getf result n))
          (setf (getf result n) (list index)))
      (incf index))
    result))

(defun calc-min-dist (plist max-dist)
  (let ((indices (cadr plist)))
    (if (> (length indices) 1)
        (- (car indices) (cadr indices))
        max-dist)))

(defun iterate-plist (plist min-dist max-dist)
  (if (null plist)
      (if (= min-dist max-dist)
          -1
          (abs min-dist))
      (iterate-plist (cddr plist) (min min-dist (calc-min-dist plist max-dist)) max-dist)))

(defun solve (input-list)
  (let ((index-list (list-indices-of-same-n input-list)))
    (iterate-plist index-list (length index-list) (length index-list))))

(main)
