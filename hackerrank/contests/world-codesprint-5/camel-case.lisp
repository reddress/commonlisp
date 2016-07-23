(defun count-uppercase (str)
  (let ((char-list (coerce str 'list)))
    (count-if #'upper-case-p char-list)))

(defun main ()
  (let ((in "aBcEl"))
    (format t "~A" (+ (count-uppercase in) 1))))

;; use read-line
(main)
