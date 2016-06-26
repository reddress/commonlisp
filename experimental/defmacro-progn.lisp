(defmacro progn-in-macro (struct-name &rest fields)
  `(progn (defstruct ,struct-name ,@fields)
          (defun MY-PROGN-FUN (,@fields)
            nil)))
