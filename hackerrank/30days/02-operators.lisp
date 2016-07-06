;; Enter your code here. Read input from STDIN. Print output to STDOUT
(let ((mealCost (read))
      (tip (read))
      (tax (read)))
     (format t "The total meal cost is ~a dollars." (round (* mealCost (+ 1 (/ (+ tip tax) 100))))))
