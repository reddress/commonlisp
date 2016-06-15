;;;; A way to control flow between various functions is throw - catch

(defun main-loop ()
  (loop (ask-human)))

(defun ask-human ()
  (format t "Enter a number: ")
  (let ((input (read)))
    (if (= input 0)
        (return-from main-loop))
    (format t "You entered: ~a~%" input)))

(defun embedded-loop ()
  (labels ((ask-human ()
             (format t "Enter a number: ")
             (let ((input (read)))
               (if (= input 0)
                   (return-from embedded-loop))
               (format t "You entered: ~a~%" input))))
    (loop (ask-human))))
