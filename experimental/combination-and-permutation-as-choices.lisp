;;; combinations of n items out of lst
(defun combinations (lst n)
  (if (= n 0)
      '()
      (cons (car lst) (combinations (cdr lst) (- n 1)))))

(defun comb-1 (lst)
  (if (null lst)
      '()
      (cons (list (car lst)) (comb-1 (cdr lst)))))

;; a
;; a b
;; a c
;; a d
;; b c
;; b d
;; c d

;; a
;; a b
;; a b c
;; a b d
;; a c d
;; b c d

;; a
;; b c d (comb b c d) is b c d
;; c d

(defun f (lst n)
  (if (= n 0)
      '()
      (progn 
        (if (null lst)
            '()
            (cons (list (car lst)) (f (cdr lst) n))))))

(defun remove-nth (n lst)
  (append (subseq lst 0 n) (nthcdr (1+ n) lst)))

(defun pick-old (lst)
  (let ((choices '()))
    (dolist (elem lst)
      (push (cons (list elem) (list (remove elem lst))) choices))
    choices))

(defun pick (choices remaining)
  (if (null remaining)
      choices
      (pick (as-choices (car remaining) choices) (cdr remaining))))

(defun add-to-choices (elem choices)
  (if (null choices)
      '()
      (cons (cons elem (car choices)) (add-to-choices elem (cdr choices)))))

;; (as-choices 'a 
(defun as-choices (elem choices)
  (if (null choices)
      '()
      ))

;; '()
;; '((a) (b) (c))
;; '((a b) (a c) (b a) (b c) (c a) (c b))
;; '((a b c) (a c b) (b a c) (b c a) (c a b) (c b a))

(defun choice-tree (tree choices)
  )

(defun choice-and-remaining (list-pair)
  (let ((choice (car list-pair))
        (remaining (cadr list-pair))
        (result '()))
    (dolist (elem remaining)
      (push (list (cons elem choice) (remove elem remaining)) result))
    result))

;; '(((a) (b c)) ((b) (a c)) ((c) (a b)))
;; '((((a b) c) (a c) (b)
