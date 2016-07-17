(defun compress (str)
  (let ((str-list (coerce str 'list)))
    (compress-helper (rest str-list) (first str-list) 1 '())))

(defparameter *test-0* "abcaaabbb")

(defun current-char-to-string (current-char times-repeated)
  (if (= times-repeated 1)
      (format t "~a" current-char)
      (format t "~a~a" current-char times-repeated)))

(defun compress-helper (str-left current-char times-repeated result)
  ;;  (format t "~a" str-left)
  (if (null str-left)
      (concatenate 'string result (current-char-to-string current-char times-repeated))
      (if (char= (first str-left) current-char)
          (compress-helper (rest str-left)
                           (first str-left)
                           (+ times-repeated 1)
                           result)
          (compress-helper (rest str-left)
                           (first str-left)
                           1
                           (concatenate 'string result
                                        (current-char-to-string current-char times-repeated))))))

(defun main ()
  (let ((s (read-line)))
    (compress s)))
