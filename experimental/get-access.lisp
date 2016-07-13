(defun get-multi (target &rest props)
  (apply #'g-helper target (reverse props)))

(defun g-helper (target &rest props)
  (if (null props)
      target
      (get (apply #'g-helper target (cdr props)) (car props))))

;;; need macro for it to be setf-able

(defmacro g. (target &rest props)
  (if props
      `(get (g. ,target ,@(butlast props)) ,(car (last props)))
      target))

;;; does not work because evaluation occurs at every level of nesting
;;; (setf (g. 'me 'age) 23)  ;; ok
;;; (setf (g. 'me 'age 'french) 'vingt)  ;; 23 is not a symbol
