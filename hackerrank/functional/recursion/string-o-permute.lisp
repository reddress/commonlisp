(defun permute-simple (str)
  (let ((char-lst (coerce str 'list)))
    (dotimes (i (/ (length char-lst) 2))
      (rotatef (nth (* i 2) char-lst)
               (nth (+ (* i 2) 1) char-lst)))
    (format t "~A~%" (coerce char-lst 'string))))

;; abcdpqrs
;; badcqpsr

;; bcdpqrs

;; bac

;; rewritten to try overcoming timeout
(defun permute (str)
  (let ((char-lst (append (nreverse (coerce str 'list)) '(#\x #\x))))
    (do ((odd (pop char-lst) (pop char-lst))
         (even (pop char-lst) (pop char-lst))
         (result '()))
        ((null char-lst) (coerce result 'string))
      (push even result)
      (push odd result))))
        
