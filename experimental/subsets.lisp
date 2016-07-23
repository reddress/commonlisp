;;; http://codereview.stackexchange.com/questions/18398/combinations-of-list-elements

(defun combinations (lst)
  (if (null lst)
      '(())
      (let ((head (car lst))
            (rest-combs (combinations (cdr lst))))
        (append rest-combs (loop for s in rest-combs collect (cons head s))))))
