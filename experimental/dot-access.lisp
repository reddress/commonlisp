(set-macro-character
 #\.
 #'(lambda (stream char)
     `(quote ,(read stream t nil t))))

;; how to access data before dot?
