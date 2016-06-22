(in-package :hc)

(deftest test-even-only
    ((equal '(5 4 7 8) (even-only '(2 5 3 4 6 7 9 8)))))



(defun even-only (lst)
  (nreverse (even-only-helper lst 1 '())))

(defun even-only-helper (lst i result)
  (if (null lst)
      result
      (even-only-helper (cdr lst)
                       (+ i 1)
                       (if (evenp i)
                           (cons (car lst) result)
                           result))))
    
