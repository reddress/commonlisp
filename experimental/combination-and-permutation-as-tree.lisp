(defun exclude (n lst)
  (append (subseq lst 0 n) (nthcdr (+ n 1) lst)))

;; n choose k
(defun c (lst k)
  (let ((result '()))
    (labels ((c-helper (lst k i)
               (if (= k 0)
                   '()
                   (push (nth i lst) result))))
      (dotimes (i (length lst))
        (c-helper lst k i)))
    result))

(defun permutations (lst n)
  (if (= n 0)
      '()
      (cons (car lst) (- n 1))))

(defun repeat-tree (lst levels)
  (if (or (null lst) (= levels 0))
      '()
      (cons (cons (car lst) (repeat-tree (cdr lst) (- levels 1)))
            (repeat-tree (cdr lst) levels))))

(defun grow-no-good (branches new-leaves)
  (if (null new-leaves)
      '()
      (if (null branches)
          (cons (list (car new-leaves)) (grow-no-good branches (cdr new-leaves)))  ;; for empty tree
          ;; (cons (cons (car new-leaves) (car branches)) (grow-no-good (cdr branches) new-leaves)))))
          (append (add-leaves (car branches) new-leaves) (grow-no-good (cdr branches) new-leaves)))))

(defun add-leaves-with-replacement (branch leaves)
  (if (null leaves)
      '()
      (cons (cons (car leaves) branch) (add-leaves-with-replacement branch (cdr leaves)))))

;;;; Working solution 

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
