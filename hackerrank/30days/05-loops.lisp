;; Enter your code here. Read input from STDIN. Print output to STDOUT
(let ((n (read)))
     (dotimes (i 10)
         (format t "~A x ~A = ~A~%" n (+ i 1) (* n (+ i 1)))))
