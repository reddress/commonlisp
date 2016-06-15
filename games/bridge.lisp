;;; see bridge062623.lisp

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
	 
(defun suit-value (suit)
  (cond ((string= suit "C") 0)
	((string= suit "D") 13)
	((string= suit "H") 26)
	((string= suit "S") 39)
	(t 0)))

(defun rank-value (rank)
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
  (+ (suit-value (suit card)) (rank-value (rank card))))

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

(defun cards-of-same-suit (hand suit)
  (remove-if-not #'(lambda (card) (equal (mkstr suit) (suit card))) hand))

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

(defun no-trump-value-to-card (index)
  (multiple-value-bind (rank suit) (floor index 4)
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

(defun lowest (hand)
  (no-trump-value-to-card 
   (apply #'min (mapcar #'no-trump-value hand))))

(defun except (hand suit)
  (if (null suit)
      hand
      (remove-if #'(lambda (card) (equal (mkstr suit) (suit card))) hand)))

(defun discard (hand lead-suit trump)
  ;; if number of cards in suit is zero, pick lowest card in hand that is not trump
  ;; otherwise, lowest of lead suit
  (play-card hand 
	     (cond ((equal 0 (cards-in-suit hand lead-suit))
		    (lowest (except hand trump)))
		   (t (lowest (cards-of-same-suit hand lead-suit))))))

(defparameter *deal* '())
(defparameter *north* '())
(defparameter *south* '())
(defparameter *east* '())
(defparameter *west* '())

(defun setup ()
  (setf *deal* (deal-hands))
  (setf *north* (sort-hand (nth 0 *deal*)))
  (setf *south* (sort-hand (nth 1 *deal*)))
  (setf *east* (sort-hand (nth 2 *deal*)))
  (setf *west* (sort-hand (nth 3 *deal*)))
  nil)

(defmacro make-play (player type-of-play &rest args)
  `(multiple-value-bind (hand card) 
       (,type-of-play ,player ,@args)
     (setf ,player hand)
     card))
    

(defun play-card (hand card)
  (values 
   (if (member card hand)
       (remove-if #'(lambda (x) (equal card x)) hand)
       (error "Card is not in hand"))
   card))

(defmacro test-discard (player)
  `(make-play ,player discard 'd 's))

(defun predefined-north ()
  (setf *north* '(AS KS QS JS 3S AH QH TH 5H 6H TC 3C AD)))

(defun cover (hand cards-played trump)
  nil)

;; follow suit when possible
;; if not, cover opponents' cards (1st and 3rd)
;; do not cover partner (discard)

  ;; find smallest card that will beat lead-card
  ;; min of set of cards that are greater than lead
;  (play-card
;   hand
;   (cond ((equal (cards-in-suit hand (suit lead-card)) 0)
;	  (if (null trump)
;	      (lowest hand)
	      ; else, play trump
;	      (progn
;		(let ((trump-cards (cards-above (cards-of-same-suit hand trump) lead-card)))
;		  (if (null trump-cards)
;		      (progn
;			(multiple-value-bind (hand card) (discard hand (suit lead-card) trump) card))
;		      (lowest trump-cards))))))
;	 (t (let ((suit-cards (cards-above (cards-of-same-suit hand (suit lead-card)) lead-card)))
;	      (if (null suit-cards)
;		  (progn
;		    (multiple-value-bind (hand card) (discard hand (suit lead-card) trump) card))
;		  (lowest (cards-above (cards-of-same-suit hand (suit lead-card)) lead-card))))))))

(defun cards-above (hand card)
  (mapcar #'no-trump-value-to-card
	  (remove-if #'(lambda (x) (< x (no-trump-value card)))
		     (mapcar #'no-trump-value hand))))

(defun cover-or-discard (hand lead-card trump)
  (let ((card-choice (cover hand lead-card trump)))
    (if (null card-choice)
	(discard hand (suit lead-card) trump)
	(cover hand lead-card trump))))

;;;; bug: to cover 9H with S as trump, JS is played
;;;; instead of 3S
