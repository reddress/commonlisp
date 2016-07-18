(defun list-of-powered (x n)
  (let ((max (floor (expt x (/ 1 n))))
        (result '()))
    (dotimes (i max)
      (let ((j (+ i 1)))
        ;; (push (cons (expt j n) j) result)))
        (push (expt j n) result)))
    result))

;; Does not work, need to skip a value sometimes
(defun search-sum (target accumulated-sum remaining-powered accumulated-integers)
  (format t "~a ~a ~a ~a~%" target accumulated-sum remaining-powered accumulated-integers)
  (if (= accumulated-sum target)
      (format t "ACCUM INT ~a~%" accumulated-integers)
      (when remaining-powered
        (let ((head (caar remaining-powered)))
          (search-sum target
                      (+ accumulated-sum head)
                      (remove-if #'(lambda (p) (> (+ (car p) accumulated-sum head) target)) (rest remaining-powered))
                      (push (cdar remaining-powered) accumulated-integers))))))

;; (search-sum 1729 0 (nthcdr 2 (list-of-powered 1729 3)) '())
;; (search-sum 100 2 (list-of-powered 100 2) '())  ; will not work

(defun test-list-of-powers (target n)
  (let ((powers (list-of-powered target n))
        (solutions 0))
    (dotimes (i (length powers))
      (if (search-sum target 0 (nthcdr i powers) '())
          (incf solutions)))
    solutions))

(defun grow (branches new-leaves)
  (if (null branches)
      '()
      (append (add-leaves (car branches) new-leaves) (grow (cdr branches) new-leaves))))

(defun add-leaves (branch leaves)
  (if (null leaves)
      '()
      (if (not (member (car leaves) branch))
          (cons (cons (car leaves) branch) (add-leaves branch (cdr leaves)))
          (add-leaves branch (cdr leaves)))))

(defun permutation-tree (choices levels)
  (if (<= levels 1)
      (add-leaves '() choices)
      (grow (permutation-tree choices (- levels 1)) choices)))

(defun combinations (choices n)
  (remove-duplicates 
   (mapcar #'(lambda (x) (sort x #'>)) (copy-tree (permutation-tree choices n)))
   :test #'equal))

(defun check-sum (lst target)
  (= target (reduce #'+ lst)))

(defun check-combinations (combinations target)
  (count t (mapcar #'(lambda (x) (check-sum x target)) combinations)))

(defun solution (x n)
  (let ((total 0)
        (list-of-powers (list-of-powered x n)))
    (dotimes (i (length list-of-powers))
      (incf total (check-combinations (combinations list-of-powers (+ i 1)) x)))
    total))

(defun main ()
  (let ((x (read))
        (n (read)))
    (format t "~a~%" (solution x n))))

;; Stack overflows

;; (main)
