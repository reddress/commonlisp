;; Day 24 More linked lists

(defparameter *list* '(1 2 2 3 3 4))

(defun my-remove-duplicates (lst)
  (if lst
      (if (not (equal (car lst) (cadr lst)))
          (cons (car lst) (my-remove-duplicates (cdr lst)))
          (my-remove-duplicates (cdr lst)))))

(my-remove-duplicates *list*)
(my-remove-duplicates '(1 1 1 1 1 1))
