(defun mingle (a b)
  (let ((a-chars (coerce a 'list))
        (b-chars (coerce b 'list))
        (result '()))
    (dotimes (i (length a-chars))
      (push (pop a-chars) result)
      (push (pop b-chars) result))
    (coerce (nreverse result) 'string)))
    
        
