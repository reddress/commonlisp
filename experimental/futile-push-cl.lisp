(defparameter *lst-of-lsts* '(() ()))

(dolist (sublist *lst-of-lsts*)
  (push 'a sublist))

;; http://stackoverflow.com/questions/16396224/common-lisp-push-from-function
(defun futile-push (thing list)
  (push thing list))

(let ((foo (list 1)))
  (futile-push 2 foo)
  foo)
