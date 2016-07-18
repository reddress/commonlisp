(defun powered (x n)
  (let ((max (floor (expt x (/ 1 n))))
        (result '()))
    (dotimes (i max)
      (let ((j (+ i 1)))
        ;; (push (cons (expt j n) j) result)))
        (push (expt j n) result)))
    result))

(defun binary-string (length n)
  (format nil (format nil "~~~a,'0b" length) n))

(defun binary-string-to-list (str)
  (mapcar #'(lambda (elem) (parse-integer (string elem))) (coerce str 'list)))

(defun binary-lists (length)
  (let ((result '()))
    (dotimes (i (expt 2 length))
      (push (binary-string-to-list (binary-string length i)) result))
    result))

(defun check (target powered binary running-total)
  (cond ((> running-total target) nil)
        ((and (null powered) (= target running-total)) t)
        ((null powered) nil)
        (t (check target (cdr powered) (cdr binary) (+ running-total (* (car powered) (car binary)))))))

(defun compare (x n)
  (let* ((powered (powered x n))
         (binary-lists (binary-lists (length powered)))
         (matches 0))
    (dolist (binary-list binary-lists)
      (if (check x powered binary-list 0)
          (incf matches)))
    matches))

;; 800 2 => 561

