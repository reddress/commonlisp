;;;; ITER-BUILDER

;;; NEW NAME: filter-transform

;;; Want to build this function more succinctly
(defun quote-all-helper (lst result)
  (if (null lst)
      (reverse result)
      (let ((head (car lst)))
        (if (not (numberp head))
            (quote-all-helper (cdr lst) (cons `(quote ,head) result))
            (quote-all-helper (cdr lst) (cons head result))))))

(defun iter-builder (car-condition accum-true &optional accum-false)
  (lambda (list-arg) 
    (labels
        ((iter (lst result)
           (let ((head (car lst)))
             (if (null lst)
                 (reverse result)
                 (if (funcall car-condition head)
                     (iter (cdr lst) (cons (funcall accum-true head) result))
                     (if accum-false
                         (iter (cdr lst) (cons (funcall accum-false head) result))
                         (iter (cdr lst) result)))))))
      (iter list-arg '()))))

(defun not-a-number (obj)
  (not (numberp obj)))

(funcall (iter-builder #'not-a-number (lambda (elem) `(quote ,elem))) '(1 2 = 3))

(setf my-built-1 (iter-builder #'not-a-number (lambda (elem) `(quote ,elem))))

(funcall my-built-1 '(1 2 3 + -))

(setf (symbol-function 'my-built-2) (iter-builder #'not-a-number (lambda (elem) `(quote ,elem))))

(setf (symbol-function 'my-built-3)
      (iter-builder
       (lambda (n) (not (numberp n)))
       (lambda (elem) `(quote ,elem))
       (lambda (elem) elem)))
