;;;         1  2  3  4 5 6 7 8 9 10 11 12 13 14 15   sum = 60
;;;  (+15) 16 17 18 ...                        sum = 165 = 7 x 15 + 60
;;;  (+30) 31 32 33 ...                        sum = 7 * 30 + 60
;;; for 7 numbers times 15, plus original 60

;;; every 15 integers the pattern repeats

(in-package :hc)

(deftest test-my-sum
    ((= 23 (my-sum 10))
     (= 60 (my-sum 16))
     (= (+ 165 60) (my-sum 31))
     (= 2318 (my-sum 100))))

(defun sum-of-n (n)
  (/ (* n (+ n 1)) 2))

(defun my-sum (x)
  (let* ((n (- x 1))
         (rows (floor n 15))
         (partial-row (loop for i from (+ (* rows 15) 1) to n collecting i)))
    (+ (* rows 60)
       (* 7 15 (sum-of-n (- rows 1)))
       (my-sum-in-list partial-row))))

(defun my-sum-in-list (lst)
(let ((sum 0))
    (dolist (i lst)
      (if (or (= (rem i 3) 0)
              (= (rem i 5) 0))
          (incf sum i)))
    sum))  

(defun my-sum-in-range (a b)
  (let ((sum 0))
    (dolist (i (loop for j from a to b collecting j))
      (if (or (= (rem i 3) 0)
              (= (rem i 5) 0))
          (incf sum i)))
    sum))

