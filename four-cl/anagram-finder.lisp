;;;; 77. Anagram Finder
;;;; 

(in-package :hc)

;;;; __ gets replaced by SOLUTION
;;
;; (deftest PROBLEM-NAME
;;     ((TEST)
;;      (equal (__ n) m)  ; example
;;      ...
;;      (TEST)
;;      (TEST)*)
;;   SOLUTION)

;; Run tests
;; (PROBLEM-NAME)

;;;; UPDATE file problem-list.txt after solving

;; http://stackoverflow.com/questions/4975633/common-lisp-how-to-check-set-equality-ignoring-order

(defun alists-equal (a b)
  (null (set-exclusive-or a b :test #'equal)))

(defun sets-equal (a b)
  (let ((a-sorted (sort-list-of-lists (sort-sublists a)))
        (b-sorted (sort-list-of-lists (sort-sublists b))))
    (null (set-exclusive-or a-sorted b-sorted :test #'equal))))

;; http://stackoverflow.com/questions/6003662/how-to-sort-a-list-with-sublists-common-lisp
(defun list< (a b)
  (cond ((null a) (not (null b)))
        ((null b) nil)
        ((string= (first a) (first b)) (list< (rest a) (rest b)))
        (t (string< (first a) (first b)))))

(defun sort-alist (alst)
  (sort alst #'(lambda (a b) (char< (car a) (car b)))))

(defun sort-sublists (s)
  (if (null s)
      '()
      (cons (sort (car s) #'string<) (sort-sublists (cdr s)))))

(defun sort-list-of-lists (s)
  (sort s #'list<))                                 

(deftest test-anagram-finder
    ((sets-equal (__ '("meat" "mat" "team" "mate" "eat"))
                 '(("meat" "team" "mate")))
     (sets-equal (__ '("veer" "lake" "item" "kale" "mite" "ever"))
                 '(("veer" "ever") ("lake" "kale") ("mite" "item"))))
  solution)

(defun string-to-letter-count (s)
  (let ((chars (coerce s 'list))
        (result '()))
    ;; histogram of characters
    (dolist (char chars)
      (if (assoc char result)
          (incf (cdr (assoc char result)))
          (setf result (acons char 1 result))))
    (sort-alist result)))

(defun anagram-finder (lst)
  (sort (pairlis (mapcar #'string-to-letter-count lst) lst)
        #'list-char<
        :key #'car))

(defparameter *test-case-2* '("veer" "lake" "item" "kale" "mite" "ever"))

(defun list-char< (a b)
  (cond ((null a) (not (null b)))
        ((null b) nil)
        ((char= (caar a) (caar b)) (list-char< (rest a) (rest b)))
        (t (char< (caar a) (caar b)))))

(defun sort-list-of-lists-char (s)
  (sort s #'list-char<))                      
  
;; recursive solution below but it is ugly
(defun group (lst equality-test)
  (let ((result '())
        (test-element nil))
    (dolist (elem lst)
      (if (funcall equality-test elem test-element)
          (push elem (first result))
          (push (list elem) result))
      (setf test-element elem))
    result))

(defun group-recursive (lst)
  (if (null lst)
      '()
      (if (equal (car lst) (cadr lst))
          (append (list (cons (car lst) (car (group-recursive (cdr lst)))))
                (cdr (group-recursive (cdr lst))))
          (cons (list (car lst)) (group-recursive (cdr lst))))))

(defun solution (list-of-words)
  (mapcar #'(lambda (sublist)
              (mapcar #'cdr sublist))
          (remove-sublists-with-single-element
           (group (anagram-finder list-of-words)
                  #'(lambda (a b) (alists-equal (car a) (car b)))))))

(defun get-cdrs (lst)
  (mapcar #'cdr lst))

(mapcar #'get-cdrs *list-of-lists*)

(defparameter *list-of-lists* '(((1 . 10) (2 . 20))
                                ((3 . 30) (5 . 50))))

(defun remove-sublists-with-single-element (lst)
  (remove-if #'(lambda (sublist) (= (length sublist) 1)) lst))
