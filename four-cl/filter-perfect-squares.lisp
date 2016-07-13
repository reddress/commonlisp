;;;; 74. Filter Perfect Squares
;;;; 

;;;; full package name :io.github.heitorchang.four-cl
(in-package :hc)

(deftest test-filter-perfect-squares
    ((equal (__ "4,5,6,7,8,9") "4,9")
     (equal (__ "15,16,25,36,37") "16,25,36"))
  filter-perfect-squares)

(defun perfect-squarep (n)
  (let ((sqrt-n (sqrt n)))
    (= sqrt-n (round sqrt-n))))

(defun filter-perfect-squares (input-string)
  (let ((input (mapcar #'parse-integer (split #\, input-string))))
    (let ((result-string (format nil "~{~a,~}" (remove-if-not #'perfect-squarep input))))
      (slice result-string 0 -1))))

(test-filter-perfect-squares)
