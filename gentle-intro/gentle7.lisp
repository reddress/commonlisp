(setf words
      '((one un)
	(two deux)
	(three trois)
	(four quatre)
	(five cinq)))

(defun translate (x)
  (second (assoc x words)))

(defun my-assoc (key table)
  (find-if #'(lambda (entry)
	       (equal key (first entry)))
	   table))

(defun rank (card)
  (first card))

(defun suit (card)
  (second card))

(defun count-suit (suit hand)
  (length (remove-if-not #'(lambda (card) (equal suit (suit card))) hand)))

;(defun helper (entry)
;  (equal key (first entry)))

(defun inalienable-rights (fn)
  (funcall fn '(life liberty and the pursuit of happiness)))

(defun make-greater-than-predicate (n)
  #'(lambda (x) (> x n)))