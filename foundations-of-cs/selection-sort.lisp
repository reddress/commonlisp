;;; Ch. 02 p. 30

(defparameter *list* '(3 1 4 1 5 9 2 6 5))

(defun selection-sort (lst)
  (let ((working-list (copy-list lst))
        (length-of-list (length lst)))
    (dotimes (i length-of-list)
      (let ((smallest-index i)
            (smallest-value (nth i working-list)))
        (dotimes (j (- length-of-list i))
          (let ((n (+ i j)))
            (when (< (nth n working-list) smallest-value)
              (setf smallest-index n)
              (setf smallest-value (nth n working-list)))))
        (rotatef (nth i working-list) (nth smallest-index working-list))))
    working-list))

(selection-sort *list*)

;;; p. 33
;;; destructive sort
(defun sel-sort (lst) 
  (for++ i 0 (- (length lst) 1)
         (let ((small i)) 
           (for++ j (1+ i) (length lst) 
                  (if (< (nth j lst) (nth small lst)) 
                      (setf small j) ))
           (rotatef (nth small lst) (nth i lst))))
  lst)  ;; return lst for convenience
