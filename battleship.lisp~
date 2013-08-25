(defun coords-to-num (coords)
  (let ((coords-str (symbol-name coords)))
    (values
     (- (parse-integer (subseq coords-str 1)) 1)
     (- (char-code (char coords-str 0)) 65))))

(defun print-board (board &optional (desc "Board"))
  (format t "   ~A~%" desc)
  (let ((rows (array-dimension board 0))
	(cols (array-dimension board 1)))
    (format t "   ")
    (dotimes (col cols)
      (format t "~A " (char "abcdefghijklmnopqrstuvwxyz" col)))
    (format t "~%")
    (dotimes (row rows)
      (if (< row 9) (format t " "))
      (format t "~A " (1+ row))
      (dotimes (col cols)
	(format t "~A " (row-major-aref board (+ (* row cols) col))))
      (format t "~%"))))

(defun is-valid-pos (row col board)
  (let ((rows (array-dimension board 0))
	(cols (array-dimension board 1)))
    (and (>= row 0)
	 (>= col 0)
	 (< row rows)
	 (< col cols))))

(defun is-valid-coords (coords board)
  (multiple-value-bind (row col)
      (coords-to-num coords)
    (is-valid-pos row col board)))

(defun read-value (coords board)
  (if (null coords)
      nil
      (progn
	(if (is-valid-coords coords board)
	    (progn
	      (multiple-value-bind (row col)
		  (coords-to-num coords)
		(aref board row col)))
	    nil))))

(defun set-value (value coords board)
  (multiple-value-bind (row col)
      (coords-to-num coords)
    (setf (aref board row col) value)))

(defun seq (start length)
  (if (= length 0)
      ()
      (cons start (seq (1+ start) (1- length)))))

(defun is-empty-for-ship (origin length is-horiz board)
  (multiple-value-bind (origin-row origin-col)
      (coords-to-num origin)
    (let ((result t))
      (if is-horiz
	  (progn
	    (dolist (col-part (seq origin-col length))
	      (if (or (not (is-valid-pos origin-row col-part board))
		      (not (equal (aref board origin-row col-part) 0)))
		  (setf result nil))))
	  (progn
	    (dolist (row-part (seq origin-row length))
	      (if (or (not (is-valid-pos row-part origin-col board))
		      (not (equal (aref board row-part origin-col) 0)))
		  (setf result nil)))))
      result)))
			
(defun place-ship (ship-symbol origin length is-horiz board)
  (multiple-value-bind (origin-row origin-col)
      (coords-to-num origin)
    (if (is-empty-for-ship origin length is-horiz board)
	(if is-horiz
	    (progn
	      (dolist (col-part (seq origin-col length))
		(setf (aref board origin-row col-part) ship-symbol))
	      t)
	    (progn
	      (dolist (row-part (seq origin-row length))
		(setf (aref board row-part origin-col) ship-symbol))
	      t))
	nil)))

;	(progn
;	  (format t "Ship will be outside the board or a ship is already in its way.~%")
;	  (format t "Enter a new origin: ")
;	  (let ((new-origin (read)))
;	    (place-ship ship-symbol new-origin length (y-or-n-p "Should the ship be placed horizontally?") board))))))

(defun reset-board (board)
  (let ((rows (array-dimension board 0))
	(cols (array-dimension board 1)))
    (dotimes (row rows)
      (dotimes (col cols)
	(setf (aref board row col) 0)))))

(defparameter *player-ships* (make-array '(10 12)))
(defparameter *player-fire* (make-array '(10 12)))
(defparameter *cpu-ships* (make-array '(10 12)))
(defparameter *cpu-fire* (make-array '(10 12)))

(defun fire (coords target-board fire-board)
  (if (or (equal (read-value coords fire-board) 'X)
	  (equal (read-value coords fire-board) 'H))
      'X
      (progn
	(let ((target-value (read-value coords target-board)))
	  (if (or (equal target-value 0) (equal target-value 'X))
	      (set-value 'X coords fire-board)
	      (set-value 'H coords fire-board))
	  (set-value 'X coords target-board)
	  target-value))))

(defparameter *ships-sunk* '())

; (push 'A *ships-sunk*)

(defun player-turn (target-board fire-board)
  (print-board *player-ships* "Your ships")
  (print-board *player-fire* "Your shots")
  (format t "Ships sunk: ~A. Enter coords: " *ships-sunk*)
  (let ((coords (read)))
    ;; cheat
    (if (equal coords 'z1)
	(print-board *cpu-ships*))
    (if (is-valid-coords coords target-board)
	(progn
	  (let ((target-value (fire coords target-board fire-board)))
	    (cond ((equal target-value 'X)
		   (format t "~A has already been fired at.~%" coords)
		   (player-turn target-board fire-board))
		  ((equal target-value 0)
		   (format t "Splash!~%"))
		  (t (format t "Hit!~%")
		     ;; check if all target-values are gone from target board
		     (if (not (exists-on-board target-value target-board))
			 (progn
			   (format t "Ship ~A sunk!~%" target-value)
			   (push target-value *ships-sunk*)
			   (if (not (board-has-ships target-board))
			       (format t "You won!~%"))))))))
	(progn
	  (format t "Coords out of bounds.~%")
	  (player-turn target-board fire-board)))))

(defun exists-on-board (ship-symbol board)
  (let ((exists nil))
    (dotimes (i (array-total-size board))
      (if (equal (row-major-aref board i) ship-symbol)
	  (setf exists t)))
    exists)) 

(defun board-has-ships (board)
  (let ((has-ships nil))
    (dotimes (i (array-total-size board))
      (if (member (row-major-aref board i) '(A B C D E F G H I J K L))
	  (setf has-ships t)))
    has-ships)) 

(defun reset-all ()
  (reset-board *player-ships*)
  (reset-board *player-fire*)
  (reset-board *cpu-ships*)
  (reset-board *cpu-fire*))

(defun random-y-or-n ()
  (if (equal 0 (random 2)) 'y nil))

(defun try-to-place-cpu-ship-randomly (ship-symbol ship-length board)
  (let* ((rows (array-dimension board 0))
	 (cols (array-dimension board 1))
	 (coords (nums-to-coords (random rows) (random cols))))
    (if (not (place-ship ship-symbol coords ship-length (random-y-or-n) board))
	(try-to-place-cpu-ship-randomly ship-symbol ship-length board))))

(defun place-cpu-ships (board)
  (try-to-place-cpu-ship-randomly 'A 5 board)
  (try-to-place-cpu-ship-randomly 'B 4 board)
  (try-to-place-cpu-ship-randomly 'C 3 board)
  (try-to-place-cpu-ship-randomly 'D 3 board)
  (try-to-place-cpu-ship-randomly 'E 2 board))

(defun try-to-place-player-ship (ship-symbol ship-length board)
  (format t "Enter ship coordinates: ")
  (let ((coords (read)))
    (if (not (place-ship ship-symbol coords ship-length
			 (y-or-n-p "Place ship horizontally?") board))
	(progn
	  (format t "Ship is out of bounds or overlapping existing ship.~%")
	  (try-to-place-player-ship ship-symbol ship-length board)))))	  
  
(defun place-player-ships (board)
  (let ((ship-specs '((a 5) (b 4) (c 3) (d 3) (e 2))))
    (dolist (ship ship-specs)
      (print-board board "Your ships")
      (format t "Select the origin for ship ~A, ~A spaces long~%" (first ship) (second ship))
      (try-to-place-player-ship (first ship) (second ship) board))))

(defparameter *cpu-hits* '())

(defun cpu-turn (target-board fire-board)
  (format t "~%My turn.~%")
  (let ((shot-coords (best-move fire-board *cpu-hits*)))
    (format t "~A~%" shot-coords)
    (let ((target-value (fire shot-coords *player-ships* *cpu-fire*)))
      (if (not (equal target-value 0))
	  (progn
	    (if (not (exists-on-board target-value target-board))
		(progn
		  (format t "Ship ~A sunk!~%" target-value)
		  (if (not (board-has-ships target-board))
		      (format t "I won!~%"))))
	    (push shot-coords *cpu-hits*)))
      (format t "~A~%" target-value))))

(defun nums-to-coords (row col)
  (intern (concatenate 'string (symbol-name (nth col '(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z))) (write-to-string (1+ row)))))

(defun above (coords)
  (multiple-value-bind (row col)
      (coords-to-num coords)
    (if (equal row 0)
	nil
	(nums-to-coords (1- row) col))))

(defun below (coords)
  (multiple-value-bind (row col)
      (coords-to-num coords)
    (nums-to-coords (1+ row) col)))

(defun left-of (coords)
  (multiple-value-bind (row col)
      (coords-to-num coords)
    (if (equal col 0)
	nil
	(nums-to-coords row (1- col)))))

(defun right-of (coords)
  (multiple-value-bind (row col)
      (coords-to-num coords)
    (nums-to-coords row (1+ col))))

(defun emptyp (coords board)
  (equal 0 (read-value coords board)))

(defun best-move (fire-board hits)
  ;; find 0s, Xs, and Hs
  (let ((zeros ())
	(misses ())
	(rows (array-dimension fire-board 0))
	(cols (array-dimension fire-board 1)))
    (dotimes (row rows)
      (dotimes (col cols)
	(let ((spot-value (aref fire-board row col)))
	  (cond ((equal spot-value 0) (push (nums-to-coords row col) zeros))
		((equal spot-value 'X) (push (nums-to-coords row col) misses))))))
    (cond ((null hits)
	   (format t "Random strategy.~%")
	   (nth (random (length zeros)) zeros))
	  ((> (length hits) 0)
	   ; (format t "Shoot at neighboring spots.~%")
	   (cond ((emptyp (above (first hits)) fire-board) (above (first hits)))
		 ((emptyp (below (first hits)) fire-board) (below (first hits)))
		 ((emptyp (left-of (first hits)) fire-board) (left-of (first hits)))
		 ((emptyp (right-of (first hits)) fire-board) (right-of (first hits)))
		 (t (best-move fire-board (cdr hits)))))
	  (t (format t "No strategy.~%")
	     (nth (random (length zeros)) zeros)))))

(defun predefined-player-ships (board)
    (place-ship 'A 'g3 5 t board)
    (place-ship 'B 'b4 4 nil board)
    (place-ship 'C 'e8 3 nil board)
    (place-ship 'D 'i9 3 t board)
    (place-ship 'E 'j6 2 nil board))

(defun play-game ()
  (reset-all)
  (setq *cpu-hits* '())
  (place-cpu-ships *cpu-ships*)
  (place-player-ships *player-ships*)
;  (predefined-player-ships *player-ships*)
  (format t "Coin toss. If (Y) I go first.~%")
  (if (random-y-or-n)
      (loop
	 (cpu-turn *player-ships* *cpu-fire*)
	 (player-turn *cpu-ships* *player-fire*))
      (loop
	 (player-turn *cpu-ships* *player-fire*)
	 (cpu-turn *player-ships* *cpu-fire*))))

;;
;   Your ships
;   a b c d e f g h i j k l 
; 1 0 0 0 0 0 0 0 0 0 0 0 0 
; 2 0 0 0 0 0 0 0 0 0 0 0 0 
; 3 0 0 0 0 0 0 A A A A A 0 
; 4 0 B 0 0 0 0 0 0 0 0 0 0 
; 5 0 B 0 0 0 0 0 0 0 0 0 0 
; 6 0 B 0 0 0 0 0 0 0 E 0 0 
; 7 0 B 0 0 0 0 0 0 0 E 0 0 
; 8 0 0 0 0 C 0 0 0 0 0 0 0 
; 9 0 0 0 0 C 0 0 0 D D D 0 
;10 0 0 0 0 C 0 0 0 0 0 0 0 