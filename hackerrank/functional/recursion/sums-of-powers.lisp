(defun list-of-powered (x n)
  (let ((max (floor (expt x (/ 1 n))))
        (result '()))
    (dotimes (i max)
      (let ((j (+ i 1)))
        (push (cons (expt j n) j) result)))
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

(defun combinations (lst)
  (if (null lst)
      '()
      (cons (list (car lst)))))


(defun pick-one (lst items-left in-hand choices)
  (if (= 0 items-left)
      choices
      (progn 
        (dolist (n (rest lst))
          (push (cons (car lst) (list n)) choices))
        (pick-one (rest lst) (- items-left 1) '() '()))))

;; https://rosettacode.org/wiki/Combinations#Common_Lisp
 
(defun rosetta-combinations (m list fn)
  (labels ((rosetta-combinations1 (l c m)
             (when (>= (length l) m)
               (if (zerop m) (return-from rosetta-combinations1 (funcall fn c)))
               ;; (if (zerop m) (return-from rosetta-combinations1 c))
               (rosetta-combinations1 (cdr l) c m)
               (rosetta-combinations1 (cdr l) (cons (first l) c) (1- m)))))
    (rosetta-combinations1 list nil m)))
 
(rosetta-combinations 5 (list-of-powered 100 2) #'print)

;; 1 2 3 4
;; 1 2  /  1 3  /  1 4  /  2 3  /  2 4  /  3 4
;; 1 2 3  /  1 2 4  /  1 3 4  /  2 3 4
;; (a b c)
;; (a) (b c)
;; '(a b)
;; '(a)
;; '(b)
;; '()

(defun exclude (n lst)
  ;; (1 2 (3) 4 5) -> (1 2 4 5)
  (append (subseq lst 0 n) (nthcdr (+ n 1) lst)))

(defun my-combination (n not-taken result)
  (if (= 0 n)
      result
      (progn
        (dolist (elem not-taken)
          (format t "~a " elem)
          (push (list elem) result))
        (my-combination (- n 1) not-taken result))))

;; http://stackoverflow.com/questions/16396224/common-lisp-push-from-function
(defun continue-taking (n not-taken result)
  (if (= 0 n)
      result
      (progn
        (dolist (choice result)   ;; is a futile push
          (dolist (remaining not-taken)
            (format t "~a " choice)
            (push remaining choice)))
        (continue-taking (- n 1) not-taken result))))
