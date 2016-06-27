;;; get odd elements
(defun get-odd (lst)
  (when lst
    (cons (car lst) (get-odd (cddr lst)))))

;;; get even elements
(defun get-even (lst)
  (get-odd (cdr lst)))

(defun solve (str)
  (let ((chars (coerce str 'list)))
    (coerce (append (get-odd chars) '(#\space) (get-even chars)) 'string)))

