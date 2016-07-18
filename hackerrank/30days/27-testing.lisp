;;;; Instead of writing a function to generate the desired output,
;;;; we generate the input that is passed to the hidden, working
;;;; function, satisfying some criteria.

;;; A test case will print YES (class canceled) or NO (class held), 

;;; desired output is YES, NO, YES, NO, YES

(format t "~A~%" "5")  ;; number of lectures (test cases)

;; total number of students and minimum number needed to hold a class
(format t "~A~%" "4 2")

;; arrival times (zero or negative = arrived on time)
(format t "~A~%" "1 3 -4 0")

(format t "~A~%" "5 3")
(format t "~A~%" "-2 -1 -2 0 1")

(format t "~A~%" "6 4")
(format t "~A~%" "1 2 3 4 0 -6")

(format t "~A~%" "7 5")
(format t "~A~%" "-2 -3 -4 -5 -3 0 5")

(format t "~A~%" "8 6")
(format t "~A~%" "1 2 3 4 5 6 0 -8")
