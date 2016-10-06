;; read INPUT-STREAM EOF-ERROR-P (set to nil to avoid default erro

;; READ CONSECUTIVE LINES

(defun read-list ()
  (let ((n (read *standard-input* nil)))  
    (if (null n)
        '()
        (cons n (read-list)))))

;; READ A GIVEN NUMBER OF TIMES

(defun read-n (n)
  (if (= n 0)
      '()
      (cons (read) (read-n (- n 1)))))

;; READ ONE AT A TIME

(let ((num-inputs (read)))
  (dotimes (i num-inputs)
    (format t "~A~%" (MY-SOLUTION-FUNCTION (read)))))

;; READ UNTIL EOF (from Practical Common Lisp)

(loop for line = (read-line *standard-input* nil)
   while line do (DO-SOMETHING-WITH-line))


(defun process-lines ()
  (let ((line (read-line *standard-input* nil)))
    (when line
      (format t "~A~%" (DO-SOMETHING))
      (process-lines))))


(defun read-space-sep-ints ()
  (read-from-string (concatenate 'string "(" (read-line) ")")))

(defun read-space-sep-strings ()
  (split #\Space (string-trim '(#\Newline) (read-line))))

(defun str-to-list (str)
  (read-from-string (concatenate 'string "(" str ")")))

;;;; PRINT A LIST

(defun print-list-one-per-line (lst)
  (format t "~{~d~%~}" lst))

(defun print-list-in-one-line (lst)
  (format t "~a" (car lst))
  (when (cdr lst)
    (format t " ")
    (print-list-in-one-line (cdr lst)))
  
