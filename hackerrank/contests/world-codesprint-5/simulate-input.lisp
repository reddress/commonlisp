(ext:cd "/home/heitor/commonlisp/hackerrank/contests/world-codesprint-5/")

(defmacro simulate (filename &body body)
  `(with-open-file (in ,filename)
     (let ((*standard-input* in))
       ,@body)))

;;; test

(defun my-square (x)
  (* x x))

(defun main () 
  (simulate
   "square-input.txt"
   
   (let ((nums (read)))
     (dotimes (i nums)
       (format t "~A~%" (my-square (read)))))))

(main)
