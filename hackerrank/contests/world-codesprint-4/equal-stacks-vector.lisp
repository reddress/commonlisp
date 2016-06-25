(declaim (optimize (speed 3) (debug 0) (safety 0)))

(defun vector-accumulate (stack-cyls)
  (declare (optimize speed) (simple-array stack-cyls)
           (sb-ext:compiler-note))
  (let* ((new-length (length stack-cyls))
         (result (make-array (+ (length stack-cyls) 1))))
    (setf (elt result new-length) 0)
    (do ((i new-length (- i 1)))
        ((= i 0) result)
      (setf (elt result (- i 1)) (+ (elt result i)
                                    (elt stack-cyls (- i 1)))))))

(defun solve (stack-1 stack-2 stack-3)
  (declare (optimize speed)
           (simple-array stack-1)
           (simple-array stack-2)
           (simple-array stack-3)
           (sb-ext:compiler-note))
  (let ((sums-1 (vector-accumulate stack-1))
        (sums-2 (vector-accumulate stack-2))
        (sums-3 (vector-accumulate stack-3)))
    (do ((i 0 (+ i 1)))
        ((> i (- (length sums-1) 1)) 0)
      (let ((cur-elem (elt sums-1 i)))
        (if (and (not (null (find cur-elem sums-2)))
               (not (null (find cur-elem sums-3))))
          (return-from solve cur-elem))))))
                    
;;; main

(defun read-space-sep-list ()
  (read-from-string (concatenate 'string "(vector " (read-line) ")")))

(defun main ()
  (let ((cyl-heights (read-line))
        (stack-1 (read-space-sep-list))
        (stack-2 (read-space-sep-list))
        (stack-3 (read-space-sep-list)))
    (format t "~a"
            (solve stack-1 stack-2 stack-3))))

;; (main)

(solve (vector 3 2 1 1 1)
       (vector 4 3 2)
       (vector 1 1 4 1))
