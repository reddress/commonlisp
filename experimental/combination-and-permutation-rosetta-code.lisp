;;; https://rosettacode.org/wiki/Combinations

(defun combinations (lst n)
  (cond ((= n 0) '(()))
        ((null lst) '())
        (t (append (mapcar #'(lambda (y) (cons (car lst) y))
                           (combinations (cdr lst) (- n 1)))
                   (combinations (cdr lst) n)))))

