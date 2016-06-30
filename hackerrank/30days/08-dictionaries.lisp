(defparameter *address-book* (make-hash-table :test #'equal))

(defun add-record (name-tel-list)
  (setf (gethash (first name-tel-list) *address-book*) (second name-tel-list)))

(defun get-record (name)
  (let ((number (gethash name *address-book*)))
    (if number
        (format nil "~a=~a" name number)
        "Not found")))

(defun split (delim str)
  (let ((index-of-delim (position delim str)))
    (if (null index-of-delim)
        (list str)
        (cons (subseq str 0 index-of-delim)
              (split delim (subseq str (+ index-of-delim 1)))))))

(defun read-space-sep-str ()
  (split #\Space (read-line)))

(defun print-names-tels ()
  (let ((name (read-line *standard-input* nil)))
    (when name
      (format t "~a~%" (get-record name))
      (print-names-tels))))

(defun main ()
  (let ((num-entries (read)))
    (dotimes (i num-entries)
      (add-record (read-space-sep-str)))
    (print-names-tels)))
    

;; (main)
     
