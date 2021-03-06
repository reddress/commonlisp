(defun solve (n m)
  ;;  (let ((weights (make-array (list (+ n 1) (+ n 1)))))
  (let ((weights '())
        (total-sum 0)
        (dist (make-array (list (+ n 1) (+ n 1)) :initial-element (expt 2 (+ n 1)))))
    ;; (dotimes m, read)
    (labels ((insert-weight (str)
               (let ((elems (str-to-list str)))
                 (push (list (nth 0 elems) (nth 1 elems)
                             (expt 2 (nth 2 elems))) weights)))

             (set-weights ()
               (dolist (edge weights)
                 (setf (aref dist (car edge) (cadr edge)) (caddr edge))
                 (setf (aref dist (cadr edge) (car edge)) (caddr edge))))
             (floyd-warshall ()

               (dotimes (i n)
                 (setf (aref dist i i) 0))
               (dolist (edge weights)
                 (setf (aref dist (car edge) (cadr edge)) (caddr edge))
                 (setf (aref dist (cadr edge) (car edge)) (caddr edge)))
               (dotimes (k (+ n 1))
                 (dotimes (i (+ n 1))
                   (dotimes (j (+ n 1))
                     (if (> (aref dist i j)
                            (+ (aref dist i k)
                               (aref dist k j)))
                         (setf (aref dist i j)
                               (+ (aref dist i k)
                                  (aref dist k j)))))))))
      ;; (read-line, str)
      (dotimes (i n)
        (insert-weight (read-line)))
      
      (floyd-warshall)

      (dolist (pair (get-pairs n))
        (incf total-sum (get-distance pair dist)))
      (format t "~b" total-sum))))

(defun range (a b)
  (loop for i from a to b collecting i))

(defun get-pairs (num-cities)
  (let ((pairs '()))
    (dolist (i (range 1 num-cities))
      (dolist (j (range (+ i 1) num-cities))
        (push (list i j) pairs)))
    pairs))

(defun get-distance (pair grid)
  (aref grid (car pair) (cadr pair)))


(defun read-space-sep-list ()
  (read-from-string (concatenate 'string "(" (read-line) ")")))

(defun str-to-list (str)
  (read-from-string (concatenate 'string "(" str ")")))

(defun insert-weight (str edges)
  (let ((elems (str-to-list str)))
    (push (list (nth 0 elems) (nth 1 elems)
                (expt 2 (nth 2 elems))) edges)))

(defun insert-weight-to-arr (str weight-arr)
  (let ((elems (str-to-list str)))
    (setf (aref weight-arr (nth 0 elems) (nth 1 elems))
          (expt 2 (nth 2 elems)))))

(defun main ()
  (let* ((m-n (read-space-sep-list))
         (m (car m-n))
         (n (cadr m-n)))         
    (solve m n)))

;; (main)
