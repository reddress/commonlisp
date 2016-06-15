;; 21 matchsticks

(defparameter *matchsticks* 21)

(defun player-turn ()
  (format t "Number of matchsticks to remove? [1-4] ")
  (let ((n (read)))
    (cond ((not (integerp n)) (format t "Please enter a number.~%") (remove-matchsticks))
          ((or (< n 1) (> n 4))
           (format t "Not a valid choice. Please try again.~%")
           (remove-matchsticks))
          ((> n *matchsticks*) (format t "Not enough matchsticks.~%") (remove-matchsticks))
          (t (setf *matchsticks* (- *matchsticks* n))))))

(defun print-matchsticks ()
  (dotimes (i *matchsticks*)
    (format t "."))
  (format t "~%")
  (dotimes (i *matchsticks*)
    (format t "|"))
  (format t " (~a) ~%" *matchsticks*))

(defun reset-matchsticks ()
  (setf *matchsticks* 21))

;; if m = 2, remove 1
;; if m = 3, remove 2
;; if m = 4, remove 3
;; if m = 5, remove 4
;; if m = 6, remove 1 -> 5 (4)
;; remove 2 -> 4 (3)
;; remove 3 -> 3 (2)
;; remove 4 -> 2 (1)
;; if m = 7, remove 1
;; if m = 8, remove 2
;; if m = 9, remove 3
;; if m = 10, remove 4
;; if m = 11, pass
;; if m = 12, remove 1
; 13 - 2
; 14 - 3
; 15 - 4
; 16 - 0
; 2, 7, 12, 17 - 1
; 3, 8, 13, 18 - 2
; 4, 9, 14, 19 - 3
; 5, 10, 15, 20 - 4
; 6, 11, 16, 21 - let user play

(defun cpu-turn ()
  (let ((n (mod (+ 4 *matchsticks*) 5)))
    (format t "I am removing ~a matchsticks.~%" n)
    (setf *matchsticks* (- *matchsticks* n))))

(defun matchsticks-game ()
  (reset-matchsticks)
  (loop do

       (print-matchsticks)
       (player-turn)
       (when (= *matchsticks* 0) (format t "You lose.~%") (return))

       (print-matchsticks)
       (cpu-turn)
       (when (= *matchsticks* 0) (format t "You win!~%") (return))
       ))
