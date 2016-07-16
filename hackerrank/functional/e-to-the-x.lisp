(defun factorial-iter (n i result)
  (if (> i n)
      result
      (factorial-iter n (+ i 1) (* i result))))

(defun factorial (n)
  (if (< n 1)
      1
      (factorial-iter n 1 1)))

(defun e-to-the-x (x n)
  (if (< n 0)
      0
      (+ (/ (expt x n) (factorial n)) (e-to-the-x x (- n 1)))))

(defun solution (x)
  (* 1.0 (e-to-the-x x 9)))
