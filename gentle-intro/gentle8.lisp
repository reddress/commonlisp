(defun anyoddp (x)
  (cond ((null x) nil)
	((oddp (first x)) t)
	(t (anyoddp (rest x)))))

(defun fact (n)
  (cond ((= n 0) 1)
	(t (* n (fact (- n 1))))))

(defun count-slices (loaf)
  (cond ((null loaf) 0)
	(t (+ 1 (count-slices (rest loaf))))))

(defun laugh (n)
  (cond ((zerop n) nil)
	(t (cons 'ha (laugh (- n 1))))))

(defun add-up (lst)
  (cond ((null lst) 0)
	(t (+ (first lst) (add-up (rest lst))))))

(defun c (n)
  (cond ((equal n 1) t)
	((evenp n) (c (/ n 2)))
	(t (c (+ (* 3 n) 1)))))

(defun tr-count-slices (loaf)
  (tr-cs1 loaf 0))

(defun tr-cs1 (loaf n)
  (cond ((null loaf) n)
	(t (tr-cs1 (rest loaf) (+ n 1)))))