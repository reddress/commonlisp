(in-package :hc)

(deftest test-my-sum
    ((= 23 (my-sum 10))
     (= 2318 (my-sum 100))))

(defun is-mult-of-3-5 (n)
  (or (= (rem n 3) 0)
      (= (rem n 5) 0)))

(defun filtered-range (n)
  (let ((range (loop for i from 1 to (- n 1) collecting i)))
    (remove-if-not #'is-mult-of-3-5 range)))

(defun my-sum (n)
  (let ((nums (filtered-range n)))
    (reduce #'+ nums)))
