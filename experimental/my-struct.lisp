(defstruct user
  name
  birthday
  favorite-number
  favorite-color
  favorite-food)

(setf j (make-user :name "Joe"
                   :birthday "2001-02-12"
                   :favorite-number 30))

(defun construct-user (varname name birthday number color food)
  (setf (symbol-value varname) (make-user
                                :name name
                                :birthday birthday
                                :favorite-number number
                                :favorite-color color
                                :favorite-food food)))

(defun prepend-to-symbol (pre sym)
  (intern (concatenate 'string pre "-" (symbol-name sym))))

(defun interleave-kw-sym (sym-lst)
  (when sym-lst
    (let ((head (car sym-lst)))
      (cons (intern (symbol-name head) "KEYWORD") (cons head (interleave-kw-sym (cdr sym-lst)))))))

(defmacro defconstruct (struct-name &rest fields)
  ;; http://stackoverflow.com/questions/5902847/how-do-i-apply-or-to-a-list-in-elisp/34946813#34946813
  (eval `(defstruct ,struct-name ,@fields))
  
  `(defmacro ,(prepend-to-symbol "CONSTRUCT" struct-name) (varname ,@fields)
     (setf (symbol-value varname)
           (,(prepend-to-symbol "MAKE" struct-name)
             ,@(interleave-kw-sym fields)))))


;;; usage

(defconstruct point-2d x y)
(defun dist (a b)
    (let ((dx (- (point-2d-x b) (point-2d-x a)))
          (dy (- (point-2d-y b) (point-2d-y a))))
      (sqrt (+ (* dx dx) (* dy dy)))))

(construct-point-2d a 0 0)
(construct-point-2d b 3 4)
(dist a b)
