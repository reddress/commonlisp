(defun construct-string (in-list seen cost)
  (if (null in-list)
      cost
      (let ((head (car in-list)))
        (if (member head seen)
            (construct-string (cdr in-list) seen cost)
            (construct-string (cdr in-list) (cons head seen) (1+ cost))))))

(ext:cd "/home/heitor/commonlisp/hackerrank/contests/world-codesprint-5/")

(defmacro simulate (filename &body body)
  `(with-open-file (in ,filename)
     (let ((*standard-input* in))
       ,@body)))

(defun main () 
  (simulate
   "string-construction.txt"
   
   (let ((num-strings (read)))
     (dotimes (i num-strings)
       (format t "~A~%"
               (construct-string (coerce (read-line) 'list)
                                 '()
                                 0))))))
                               
(main)
