(in-package :hc)

(deftest test-my-sum
    ((= 23 (my-sum 10))
     (= 2318 (my-sum 100))))

(defun my-sum (n)
  (let ((sum 0))
    (dotimes (i n)
      (if (or (= (rem i 3) 0)
              (= (rem i 5) 0))
          (incf sum i)))
    sum))
        
            
            
