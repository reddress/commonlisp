(defun jumps-iter (x v i n result)
  "Construct a list of n jumps, starting at x with rate v"
  (if (= i n)
      (reverse result)
      (jumps-iter x v (+ i 1) n (cons (+ x (* i v)) result ))))

(defun jumps-race (x1 v1 x2 v2 n)
  (let ((jumps1 (jumps-iter x1 v1 0 n '()))
        (jumps2 (jumps-iter x2 v2 0 n '())))
    (mapcar #'- jumps1 jumps2)))

;;; SOLVE

(defun read-space-sep-list ()
  (read-from-string (concatenate 'string "(" (read-line) ")")))

(defun str-to-list (str)
  (read-from-string (concatenate 'string "(" str ")")))

(defun step (a-x a-v b-x b-v)
  (cond (((= a-x b-x) "YES")
         (
      "YES"
      (if 
       (determine (a-x )))))))

;; 0 3 4 2 => YES
;; 0 2 5 3 => NO


;; Kangaroo's position is expressed as Y = vX + P
(defun solve-system (p1 v1 p2 v2)
  (cond ((= (- v1 v2) 0) "NO")
        (t (let ((solution (/ (- p2 p1) (- v1 v2))))
             (cond ((and (> solution 0)
                         (= (round solution) solution)) "YES")
                   (t "NO"))))))
  
(defun solve (input-str)
  (apply #'solve-system (str-to-list input-str)))
