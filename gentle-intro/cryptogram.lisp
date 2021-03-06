(setf *crypto-text* "zj ze kljjls jf slapzi ezvlij pib kl jufwxuj p hffv jupi jf enlpo pib slafml pvv bfwkj")

(setf *encipher-table* (make-hash-table))
(setf *decipher-table* (make-hash-table))

(defun make-substitution (coded decoded)
  (setf (gethash coded *decipher-table*) decoded)
  (setf (gethash decoded *encipher-table*) coded))

(defun undo-substitution (letter)
  (setf (gethash (gethash letter *decipher-table*) *encipher-table*) nil)
  (setf (gethash letter *decipher-table*) nil))

(defun clear ()
  (clrhash *encipher-table*)
  (clrhash *decipher-table*))

(defun decipher-string (encoded-string)
  (let ((output (make-string (length encoded-string) :initial-element #\Space)))
    (dotimes (i (length encoded-string))
      (setf (char output i) (or (gethash (char encoded-string i) *decipher-table*) #\Space)))
    output))

(defun show-line ()
  (format t "~a~%" *crypto-text*)
  (format t "~a~%" (decipher-string *crypto-text*)))

(defun get-first-char (x)
  (char-downcase
   (char (format nil "~A" x) 0)))

(defun read-letter ()
  (let ((input (read)))
    (cond ((equal input 'end) 'end)
	  ((equal input 'undo) 'undo)
	  (t (get-first-char input)))))

(defun sub-letter (which-char)
  (if (gethash which-char *decipher-table*)
      (format t "Letter has been deciphered already.")
      (progn 
	(format t "What should ~a decipher to? " which-char)
	(let ((to-char (read)))
	  (make-substitution which-char (get-first-char to-char))))))

(defun undo-letter ()
  (format t "Undo which letter? ")
  (let ((choice (read)))
    (if (gethash (get-first-char choice) *decipher-table*)
	(undo-substitution (get-first-char choice))
	(format t "~a has not been assigned." choice))))

(defun solve ()
  (loop do
       (show-line)
       (format t "Substitute which letter? [or end/undo] ")
       (let ((user-input (read-letter)))
	 (cond ((equal user-input 'end) (return))
	       ((equal user-input 'undo) (undo-letter))
	       (t (sub-letter (get-first-char user-input)))))))
