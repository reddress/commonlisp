(deftest test-luck-balance
    ((= 29 (faster-luck-balance '((5 1) (2 1) (1 1) (8 1) (10 0) (5 0)) 3))))

(defun total-luck (contests)
  (reduce #'+ (mapcar #'car contests)))

(defun luck-balance (contests k)
  ;; lose K important contests (sorted by max to min), increasing luck
  ;; lose all unimportant contests, increasing luck
  ;; win (num-important - K) important contests
  (let ((important-contests
         (sort (remove-if-not #'(lambda (contest) (= (cadr contest) 1)) contests) #'(lambda (x y) (> (car x) (car y)))))
        (unimportant-contests
         (remove-if-not #'(lambda (contest) (= (cadr contest) 0)) contests)))
    (let ((failed-important-contests
           (subseq important-contests 0 k))
          (passed-important-contests
           (nthcdr k important-contests)))
      (+ (total-luck failed-important-contests)
         (- (total-luck passed-important-contests))
         (total-luck unimportant-contests)))))

(defun faster-luck-balance (contests k)
  ;; lose K important contests (sorted by max to min), increasing luck
  ;; lose all unimportant contests, increasing luck
  ;; win (num-important - K) important contests

  (let ((won-contests
         (nthcdr
          k
          (sort (remove-if-not
                 #'(lambda (contest) (= (cadr contest) 1))
                 contests)
                #'(lambda (x y) (> (car x) (car y)))))))
    ;; (format t "~a" won-contests)
    (- (total-luck contests) (* 2 (total-luck won-contests)))))

(faster-luck-balance '((5 1) (2 1) (1 1) (8 1) (10 0) (5 0)) 3)

(total-luck '((5 1) (2 1) (1 1) (8 1) (10 0) (5 0)))

(defun read-space-sep-list ()
  (read-from-string (concatenate 'string "(" (read-line) ")")))

(defun solve ()
  (let ((num-contests (read))
        (k (read))
        (contests '()))
    (dotimes (i num-contests)
      (push (read-space-sep-list) contests))
    (format t "~a" contests)))
