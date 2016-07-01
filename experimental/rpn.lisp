;;;; Reverse Polish Notation

(defparameter *rpn-stack* '())

;; (rpn-calc 3 4 5 +) => 9 (3 stays in stack)
;; (rpn-calc 2 3 +) => 5
;; (rpn-calc 3 10 * 2 +) => 32
;; (rpn-calc +) => error (require all function calls to use 2 arguments)

(deftest test-rpn-calc
    ((= 9 (rpn 3 4 5 +))
     (= 5 (rpn 2 3 +))
     (= 32 (rpn 3 10 * 2 +))))

;; (apply (symbol-function (car '(+ 1 2))) (cdr '(+ 1 2))) => 3

(defun rpn-push (val)
  (if (numberp val)
      (push val *rpn-stack*)
      (if (member val '(sqrt exp log))
          (if (< (length *rpn-stack*) 1)
              (error "Error: must call ~a with at least one value in the stack" val)
              (compute-1-arg val))
          (if (< (length *rpn-stack*) 2)
              (error "Error: must call ~a with at least two values in the stack" val)
              (compute-2-args val)))))

(defun compute-1-arg (op)
  (let ((x (pop *rpn-stack*)))
    (rpn-push (funcall (symbol-function op) x))))

(defun compute-2-args (op)
  (let ((x (pop *rpn-stack*))
        (y (pop *rpn-stack*)))
    (rpn-push (funcall (symbol-function op) x y))))

(defun rpn-pop ()
  (let ((val (pop *rpn-stack*)))
    val))

(defun rpn-calc (&rest lst)
  (if (null lst)
      (car *rpn-stack*)
      (progn
        (rpn-push (car lst))
        (apply #'rpn-calc (cdr lst)))))

(defun rpn-clear ()
  (setf *rpn-stack* '()))

(defun rpn-stack ()
  *rpn-stack*)

(defun quote-all-helper (lst result)
  (if (null lst)
      (reverse result)
      (let ((head (car lst)))
        (if (not (numberp head))
            (quote-all-helper (cdr lst) (cons `(quote ,head) result))
            (quote-all-helper (cdr lst) (cons head result))))))

(defun quote-all (lst)
  (quote-all-helper lst '()))
  
;;; save the trouble of quoting operators
(defmacro rpn (&rest args)
  `(rpn-calc ,@(quote-all args)))
