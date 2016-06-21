;;; p. 388
(setf fact
      (lambda (f n)
        (if (= n 0)
            1
            (* n (funcall f f (- n 1))))))

(defun recurser (fn)
  (lambda (&rest args)
    (apply fn fn args)))

(funcall
 ((lambda (f) (lambda (n) (funcall f f n)))
  (lambda (f n)
    (if (= n 0)
        1
        (* n (funcall f f (- n 1))))))
 5)  ; uao
