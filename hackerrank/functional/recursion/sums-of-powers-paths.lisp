(defun powered (x n)
  (let ((max (floor (expt x (/ 1 n))))
        (result '()))
    (dotimes (i max)
      (let ((j (+ i 1)))
        (push (expt j n) result)))
    (reverse result)))
    ;; result))

(defparameter *p* (powered 100 2))

(defun next-combination (current carry)
  ;; 0 0 0 0 0
  ;; 1 0 0 0 0
  ;; 0 1 0 0 0
  ;; 1 1 0 0 0 
  ;; 0 0 1 0 0
  ;; 1 0 1 0 0
  ;; 0 1 1 0 0
  ;; 1 1 1 0 0
  (if (null current)
      '()
      (let* ((sum (+ (car current) carry))
             (next-carry (if (= sum 2) 1 0))
             (new-head (rem sum 2)))
        (cons new-head (next-combination (cdr current) next-carry)))))

(defun combination-sum (values choices)
  (reduce #'+ (mapcar #'* values choices)))

(defun set-to-one-the-first-zero-after-a-one (combination one-found)
  (if (null combination)
      '()
      (let ((head (car combination)))
        (if (= head 1)
            (cons 0 (set-to-one-the-first-zero-after-a-one (cdr combination) t))
            (if (and (= (car combination) 0) one-found)
                (cons 1 (cdr combination))
                (cons 0 (set-to-one-the-first-zero-after-a-one (cdr combination) one-found)))))))

(defun repeat (n x)
  (loop for i from 1 to n collecting x))

(defun check (target powered binary running-total)
  (cond ((> running-total target) nil)
        ((and (null powered) (= target running-total)) t)
        ((null powered) nil)
        (t (check target (cdr powered) (cdr binary) (+ running-total (* (car powered) (car binary)))))))

(defun check-sums (values target)
  (let ((powers-of-two (loop for i from 1 to (length values) collecting (expt 2 i))))
    
    (do* ((choice (repeat (length values) 0) (next-with-target choice values target))
          (good-choices '())
          (choices-seen '())
          (choice-as-int -1 (combination-sum powers-of-two choice)))
         ;; ((member choice-as-int choices-seen) (length good-choices))
         ((member choice good-choices :test #'equal) (length good-choices))
      ;; (format t "~a ~a~%" choice (combination-sum values choice))
      (if (check target values choice 0) (push choice good-choices)))))
      ;; (push choice-as-int choices-seen))))
            
(defun next-with-target (combination values target)
  (if (>= (combination-sum values combination) target)
      (set-to-one-the-first-zero-after-a-one combination nil)
      (next-combination combination 1)))

(defun solution (x n)
  (if (< (reduce #'+ (powered x n)) x)
      0  ;; if total sum is less than x, nothing can possibly work
      (check-sums (powered x n) x)))

(defun main ()
  (let ((x (read))
        (n (read)))
    (format t "~A~%" (solution x n))))

;; (main)
