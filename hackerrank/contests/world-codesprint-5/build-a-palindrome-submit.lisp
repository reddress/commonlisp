(defun check-longest (a b-raw)
  (let ((longest "")
        (b (reverse b-raw)))
    (dotimes (i (length a))
      (let ((current-check (check-sequence (subseq a i) b)))
        (cond ((= (length current-check) (length longest))
               (if (string< current-check longest)
                   (setf longest current-check)))
              ((> (length current-check) (length longest))
               (setf longest current-check)))))
    longest))

(defun check-sequence (base target)
  (let ((base-len (length base))
        (check-string (concatenate 'string base "0"))
        (longest-sequence ""))
    (dotimes (i (+ base-len 2))
      (if (not (search (subseq check-string 0 i) target))
          (return-from check-sequence (subseq base 0 (- i 1)))))))

(defun string-with-right-of (substr str)
  (if (= (length substr) 0)
      ""
      (progn
        (let ((index (search substr str))
              (substr-len (length substr))
              (str-len (length str)))
          (if (= str-len (+ index substr-len))
              substr
              (subseq str index (+ index (length substr) 1)))))))

(defun string-with-left-of (substr str-raw)
  (let ((str (reverse str-raw)))
    (string-with-right-of substr str)))
         
(defun build-left-palindrome (a b)
  (let* ((shared (check-longest a b))
         (left (string-with-right-of shared a))
         (right (string-with-left-of shared b))
         (len-left (length left))
         (len-right (length right))
         (chosen
          (cond ((= len-left len-right 0) "-1")
                ((> len-left len-right) left)
                ((> len-right len-left) right)
                ((string< left right) left)
                (t right)))
         (palindrome
          (cond ((string= chosen "-1") "-1")
                ((string= left right) (concatenate 'string chosen (reverse chosen)))
                (t (concatenate 'string chosen (subseq (reverse chosen) 1))))))
    palindrome))

(defun main ()
  (let ((num-tests (read)))
    (dotimes (i num-tests)
      (format t "~A~%" (build-left-palindrome (read-line) (read-line))))))

;; (main)
