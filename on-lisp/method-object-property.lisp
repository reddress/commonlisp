;;;; p. 15 Functions as properties

;;; action functions
(defun wag-tail ()
  (format t "*wag* *wag*~%"))

(defun bark ()
  (format t "Woof Woof~%"))

(defun scurry ()
  (format t "*shuffle* *shuffle*~%"))

(defun squeak ()
  (format t "Squeeeeeak~%"))

(defun rub-legs ()
  (format t "*rub* *rub*~%"))

(defun scratch-carpet ()
  (format t "*scratch*~%"))

(defun meow ()
  (format t "Meow Meow~%"))

(defun chirp ()
  (format t "Chirp Chirp~%"))

(defun fly ()
  (format t "*flap* *flap*~%"))

(defun behave-case (animal)
  (case animal
    (dog (wag-tail)
         (bark))
    (rat (scurry)
         (squeak))
    (cat (meow)
         (rub-legs)
         (scratch-carpet))))

(defun behave-call (animal)
  (funcall (get animal 'behavior)))

(setf (get 'dog 'behavior)
      #'bark)

(setf (get 'bird 'behavior)
      #'(lambda ()
          (chirp)
          (fly)))
