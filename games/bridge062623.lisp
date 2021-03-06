;;;; month-day-hour
;;;; 062617 (2013)

;;;; special variables
(defparameter *deal* '())
(defparameter *north* '())
(defparameter *south* '())
(defparameter *east* '())
(defparameter *west* '())

(defparameter *ns-tricks* 0)
(defparameter *ew-tricks* 0)
(defparameter *current-player* '*west*)

(defparameter *hand-trump* nil)
(defparameter *bid-history* '())

(defun setup ()
  (setf *deal* (deal-hands))
  (setf *north* (sort-hand (nth 0 *deal*)))
  (setf *south* (sort-hand (nth 1 *deal*)))
  (setf *east* (sort-hand (nth 2 *deal*)))
  (setf *west* (sort-hand (nth 3 *deal*)))
  
  (setf *ns-tricks* 0)
  (setf *ew-tricks* 0)
  (setf *current-player* '*west*)

  (setf *hand-trump* nil)
  (setf *bid-history* '())
  nil)

;;;; utility functions
(defun mkstr (&rest args)
  (with-output-to-string (s)
    (dolist (a args) (princ a s))))

(defun combine-symbols (&rest args)
  (values (intern (apply #'mkstr args))))

(defun group (source n)
  (if (zerop n) (error "zero length group"))
  (labels ((rec (source acc)
	     (let ((rest (nthcdr n source)))
	       (if (consp rest)
		   (rec rest (cons (subseq source 0 n) acc))
		   (nreverse (cons source acc))))))
    (if source (rec source nil) nil)))

(defun repeat (symbol times)
  (if (equal times 0)
      '()
      (cons symbol (repeat symbol (1- times)))))

(defun index-of-match (s lst)
  (labels ((rec (s lst inx)
	     (if (null lst)
		 nil
		 (progn
		   (if (equal (first lst) s)
		       inx
		       (rec s (rest lst) (1+ inx)))))))
    (rec s lst 0)))

(defun new-deck ()
  ;; return brand new, ordered deck of 52 cards
  (let ((deck '()))
    (dolist (suit '(C D H S))
      (dolist (rank '(2 3 4 5 6 7 8 9 T J Q K A))
	(push (combine-symbols rank suit) deck)))
    deck))

(defun pick-random-element (lst)
  (let ((picked (random (length lst))))
    (values
     (nth picked lst)
     (append (subseq lst 0 picked) (subseq lst (1+ picked))))))

(defun shuffle (source dest)
  (if (null source)
      dest
      (progn
	(multiple-value-bind (picked-card source-minus-one)
	    (pick-random-element source)
	  (shuffle source-minus-one (cons picked-card dest))))))

(defun deal-hands ()
  ;; return 4 lists, each with 13 cards
  (let ((shuffled-deck (shuffle (new-deck) '())))
    (group shuffled-deck 13)))

(defun rank (card)
  (subseq (symbol-name card) 0 1))

(defun suit (card)
  (subseq (symbol-name card) 1))

(defun hcp (card)
  (let ((card-rank (rank card)))
    (cond ((string= card-rank "A") 4)
	  ((string= card-rank "K") 3)
	  ((string= card-rank "Q") 2)
	  ((string= card-rank "J") 1)
	  (t 0))))

(defun hand-hcp (hand)
  ;; hand is a list of cards
  (reduce #'+ (mapcar #'hcp hand)))

;;;; to sort by suit and then rank
;;;; AS KS QS JS ... 2S AH ... 2H AD ... 2D AC ... 2C
;;;; 52 51 50 49     40 39 ... 27 26 ... 14 13 ... 1

(defun card-index-to-symbol (index)
  (let ((rank-index (mod index 13)))
    (intern
     (mkstr
      (nth rank-index '(A 2 3 4 5 6 7 8 9 T J Q K))
      (cond ((> index 39) "S")
	    ((> index 26) "H")
	    ((> index 13) "D")
	    (t "C"))))))
	 
(defun suit-index-value (suit)
  (cond ((string= suit "C") 0)
	((string= suit "D") 13)
	((string= suit "H") 26)
	((string= suit "S") 39)
	(t 0)))

(defun rank-index-value (rank)
  (cond ((string= rank "A") 13)
	((string= rank "K") 12)
	((string= rank "Q") 11)
	((string= rank "J") 10)
	((string= rank "T") 9)
	((string= rank "9") 8)
	((string= rank "8") 7)
	((string= rank "7") 6)
	((string= rank "6") 5)
	((string= rank "5") 4)
	((string= rank "4") 3)
	((string= rank "3") 2)
	((string= rank "2") 1)
	(t 0)))

(defun card-index (card)
  (+ (suit-index-value (suit card)) (rank-index-value (rank card))))

(defun sort-hand (hand)
  (mapcar #'card-index-to-symbol
	  (sort (mapcar #'card-index hand) #'>)))

(defun print-hand (hand)
  (format t "~A~%" hand))

(defun cards-in-suit (hand suit)
  (reduce #'+ (mapcar #'card-is-suit hand (repeat (mkstr suit) (length hand)))))

(defun card-is-suit (card suit)
  (if (equal (mkstr suit) (suit card))
      1
      0))

(defun distribution-points (cards-in-suit)
  (cond ((equal cards-in-suit 2) 1)
	((equal cards-in-suit 1) 2)
	((equal cards-in-suit 0) 3)
	((equal cards-in-suit 6) 1)
	((equal cards-in-suit 7) 2)
	((> cards-in-suit 8) 3)
	(t 0)))

(defun hand-points (hand)
  (+ (hand-hcp hand)
     (distribution-points (cards-in-suit hand 'S))
     (distribution-points (cards-in-suit hand 'H))
     (distribution-points (cards-in-suit hand 'D))
     (distribution-points (cards-in-suit hand 'C))))

(defun majorp (suit)
  (if (or (equal (mkstr suit) "S")
	  (equal (mkstr suit) "H"))
      t nil))

(defun cards-of-suit (hand suit)
  (if (null suit)
      hand
      (remove-if-not #'(lambda (card) (equal (mkstr suit) (suit card))) hand)))

(defun no-trump-value (card)
  ;; 2C 2D 2H 2S 3C 3D ...
  ;; 0  1  2  3  4  5  
  (let ((card-rank (rank card))
	(card-suit (suit card)))
    (+
     (cond ((equal card-rank "2") 0)
	   ((equal card-rank "3") 4)
	   ((equal card-rank "4") 8)
	   ((equal card-rank "5") 12)
	   ((equal card-rank "6") 16)
	   ((equal card-rank "7") 20)
	   ((equal card-rank "8") 24)
	   ((equal card-rank "9") 28)
	   ((equal card-rank "T") 32)
	   ((equal card-rank "J") 36)
	   ((equal card-rank "Q") 40)
	   ((equal card-rank "K") 44)
	   ((equal card-rank "A") 48)
	   (t 0))
     (cond ((equal card-suit "C") 0)
	   ((equal card-suit "D") 1)
	   ((equal card-suit "H") 2)
	   ((equal card-suit "S") 3)))))

(defun card-value-to-card (index)
  (multiple-value-bind (rank suit) (floor (mod index 100) 4)
    (intern
     (mkstr
      (cond ((equal rank 0) "2")
	    ((equal rank 1) "3")
	    ((equal rank 2) "4")
	    ((equal rank 3) "5")
	    ((equal rank 4) "6")
	    ((equal rank 5) "7")
	    ((equal rank 6) "8")
	    ((equal rank 7) "9")
	    ((equal rank 8) "T")
	    ((equal rank 9) "J")
	    ((equal rank 10) "Q")
	    ((equal rank 11) "K")
	    ((equal rank 12) "A")
	    (t "X"))
      (cond ((equal suit 0) "C")
	    ((equal suit 1) "D")
	    ((equal suit 2) "H")
	    ((equal suit 3) "S"))))))

(defun card-value (card trump-suit)
  (if (string= (suit card) (mkstr trump-suit))
      (+ 100 (no-trump-value card))
      (no-trump-value card)))

(defun lowest (hand trump-suit)
  (if (null hand)
      nil
      (progn
	(card-value-to-card 
	 (apply #'min (mapcar #'(lambda (x) (card-value x trump-suit)) hand))))))

(defun highest (hand trump-suit)
  (if (null hand)
      nil
      (progn
	(card-value-to-card
	 (apply #'max (mapcar #'(lambda (x) (card-value x trump-suit)) hand))))))

(defun except (hand suit)
  (if (null suit)
      hand
      (remove-if #'(lambda (card) (equal (mkstr suit) (suit card))) hand)))

(defun discard (hand lead-suit trump)
  ;; if number of cards in suit is zero, pick lowest card in hand that is not trump
  ;; otherwise, lowest of lead suit
  (play-card
   hand 
   (cond ((> (cards-in-suit hand lead-suit) 0)
	  (lowest (cards-of-suit hand lead-suit) trump))
	 ((equal 0 (cards-in-suit hand lead-suit))
	  (let ((non-trump-cards (except hand trump)))
	    (if (not (null non-trump-cards))
		(lowest non-trump-cards trump)
		(lowest hand trump)))))))	     

(defun pick-lowest (hand trump-suit)
  (play-card hand
	     (lowest hand trump-suit)))

(defun display ()
  (format t "   ~A~%~%" *north*)
  (format t "~A~%" *west*)
  (format t "      ~A~%~%" *east*)
  (format t "   ~A~%~%" *south*)
  (format t "Trump: ~A~%N-S tricks: ~A  E-W tricks: ~A~%~%" *hand-trump* *ns-tricks* *ew-tricks*))


(defun ask-human (hand cards-played)
  (format t "Which card? ")
  (let ((card (read)))
    (if (not (member card hand))
	(progn (format t "Card not in hand. ") (ask-human hand cards-played))
	(progn
	  (if (not (member card (valid-moves hand cards-played)))
	      (progn (format t "You must follow suit. ") (ask-human hand cards-played))
	      (play-card hand card))))))

(defmacro make-play (player type-of-play &rest args)
  `(multiple-value-bind (card hand) 
       (,type-of-play ,player ,@args)
     (setf ,player hand)
     (format t "~A played.~%~%" card)
     (values card hand)))
    

(defun play-card (hand card)
  (if (not (null hand))
      (progn
	(values
	 card
	 (if (member card hand)
	     (remove-if #'(lambda (x) (equal card x)) hand)
	     (error "Card is not in hand"))))))

(defun predefined-south ()
  (setf *south* '(AS KS QS JS 3S AH QH TH 5H 6H TC 3C AD)))

(defun predefined-north ()
  (setf *north* '(JS 9S 8S 6S 4S AH 8H 4H 2H QC TC 5C 2C)))

(defun cover (hand cards-played trump-suit)
  (let* ((high-card (get-high-card cards-played trump-suit))
	 (lead-suit (suit (first cards-played)))
	 (cards-in-lead-suit (cards-in-suit hand lead-suit))
	 (cards-in-trump-suit (cards-in-suit hand trump-suit)))
    (play-card
     hand
     (cond ((> cards-in-lead-suit 0)
	    (let ((cards-above-high-card (cards-of-suit (cards-above hand high-card trump-suit) lead-suit)))
	      (if (null cards-above-high-card)
		  (discard hand lead-suit trump-suit)
		  (lowest cards-above-high-card trump-suit))))
	   ;; otherwise try playing a trump
	   ((> cards-in-trump-suit 0)
	    (let ((cards-above-high-card (cards-of-suit (cards-above hand high-card trump-suit) trump-suit)))
	      (if (null cards-above-high-card)
		  (discard hand lead-suit trump-suit)
		  (lowest cards-above-high-card trump-suit))))
	   (t (print "NOTE: playing lowest") (lowest hand trump-suit))))))

(defun get-high-card (cards-played trump-suit)
  (card-value-to-card
   (apply #'max (mapcar #'(lambda (x) (card-value-in-trick x (first cards-played) trump-suit)) cards-played))))

(defun card-value-in-trick (card lead-card trump-suit)
  (let ((lead-suit (suit lead-card)))
    (cond ((equal (suit card) (mkstr trump-suit)) (card-value card trump-suit))
	  ((not (equal (suit card) lead-suit)) 0)
	  (t (card-value card trump-suit)))))

(defun cards-above (hand card trump-suit)
  (mapcar #'card-value-to-card
	  (remove-if #'(lambda (x) (< x (card-value card trump-suit)))
		     (mapcar #'(lambda (x) (card-value x trump-suit)) hand))))

(defun cover-opponents (hand cards-played trump-suit)
  (cond ((equal (length cards-played) 1)
	 (cover hand cards-played trump-suit))
	((equal (length cards-played) 2)
	 (if (card> (first cards-played) (second cards-played) (suit (first cards-played)) trump-suit)
	     (discard hand (suit (first cards-played)) trump-suit)
	     (cover hand (list (second cards-played)) trump-suit)))
	((equal (length cards-played) 3)
	 (if (card> (second cards-played) (greater-card (first cards-played) (third cards-played) (suit (first cards-played)) trump-suit) (suit (first cards-played)) trump-suit)
	     (discard hand (suit (first cards-played)) trump-suit)
	     (cover hand (list (first cards-played) (third cards-played)) trump-suit)))))

(defun play-to-win (hand cards-played trump)
  (let ((lead-suit (suit (first cards-played)))
	(num-cards (length cards-played))
	(highest-valid (highest (valid-moves hand cards-played) trump)))
    
    (play-card
     hand
     (cond ((equal num-cards 0) (highest hand trump))
	   ((equal num-cards 1)
	    (if (card> highest-valid (first cards-played) lead-suit trump)
		highest-valid
		(discard hand lead-suit trump)))
	   ((equal num-cards 2)
	    (if (card> (second cards-played) highest-valid lead-suit trump)
		(discard hand lead-suit trump)
		(progn
		  (if (card> highest-valid (first cards-played) lead-suit trump)
		      (if (equivp highest-valid (first cards-played))
			  (discard hand lead-suit trump)
			  highest-valid)
		      (discard hand lead-suit trump)))))
	   ((equal num-cards 3)
	    (let ((highest-opp-card (greater-card (first cards-played) (third cards-played) lead-suit trump)))
	      (if (card> (second cards-played) highest-opp-card lead-suit trump)
		  (discard hand lead-suit trump)
		  (progn		    
		    (if (card> highest-valid highest-opp-card lead-suit trump)
			(lowest (cards-above (valid-moves hand cards-played) highest-opp-card trump) trump)
			(discard hand lead-suit trump))))))))))

(defun equivp (card-a card-b)
  (if (equal (suit card-a) (suit card-b))
      (<= (abs (- (rank-index-value (rank card-a))
		  (rank-index-value (rank card-b)))) 1)))

(defun card> (card-a card-b lead-suit trump-suit)
  (let ((card-a-value (card-value card-a trump-suit))
	(card-b-value (card-value card-b trump-suit)))
    (if (not (equal (suit card-a) (mkstr lead-suit)))
	(setf card-a-value 0))
    (if (not (equal (suit card-b) (mkstr lead-suit)))
	(setf card-b-value 0))
    (> card-a-value card-b-value)))

(defun greater-card (card-a card-b lead-suit trump-suit)
  (if (card> card-a card-b lead-suit trump-suit) card-a card-b))

(defun valid-moves (hand cards-played)
  (let ((lead-suit (suit (first cards-played))))
    (if (equal (length (cards-of-suit hand lead-suit)) 0)
	hand
	(cards-of-suit hand lead-suit))))

;;;; add "counting cards" feature, that keeps track of cards played
;;;; how to manage 50-50 plays, finesses???

(defun next-player ()
  (cond ((equal *current-player* '*west*) (setf *current-player* '*north*))
	((equal *current-player* '*north*) (setf *current-player* '*east*))
	((equal *current-player* '*east*) (setf *current-player* '*south*))
	((equal *current-player* '*south*) (setf *current-player* '*west*))))

(defmacro add-to-trick (&rest play-type)
  `(setf cards-played (append cards-played (list (make-play (symbol-value *current-player*) ,@play-type)))))

(defun print-turn ()
  (format t "~A's turn.~%" *current-player*))

(defun run-trick ()
  (display)
  (let ((cards-played nil))
    (dotimes (i 4)
      (print-turn)
      (cond ((equal *current-player* '*south*)
	     (add-to-trick ask-human cards-played))
	    (t (add-to-trick play-to-win cards-played *hand-trump*)))
      (next-player))

    (format t "~A~%" cards-played)
    (let* ((high-card (get-high-card cards-played *hand-trump*))
	   (winning-player (index-to-player (mod (+ (player-index *current-player*) (index-of-match high-card cards-played)) 4))))
      (setf *current-player* winning-player)
      (format t "~A wins this trick.~%~%" winning-player))

    ;; add to trick count
    (cond ((or (equal *current-player* '*north*)
	       (equal *current-player* '*south*))
	   (incf *ns-tricks*))
	  (t (incf *ew-tricks*)))))

(defun player-index (name)
  (cond ((equal name '*west*)  0)
	((equal name '*north*) 1)
	((equal name '*east*)  2)
	((equal name '*south*) 3)))

(defun index-to-player (inx)
  (cond ((equal inx 0) '*west*)
	((equal inx 1) '*north*)
	((equal inx 2) '*east*)
	((equal inx 3) '*south*)))

(defun sample-hand ()
  (dotimes (turn 13)
    (run-trick)))

;;;; bidding
(defun bid ()
  (let* ((hand (symbol-value *current-player*))
	 (points (hand-points hand)))
    points))
