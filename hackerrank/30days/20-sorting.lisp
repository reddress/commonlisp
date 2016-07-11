(defun bubble-sort (lst)
  (let ((num-swaps 0)
        (lst-len (length lst)))
    (dotimes (i lst-len)
      (dotimes (j (- lst-len 1))
        (when (> (nth j lst) (nth (+ j 1) lst))
          (incf num-swaps)
          (rotatef (nth j lst) (nth (+ j 1) lst)))))
    ;; (format t "~a" lst)
    (format t "Array is sorted in ~a swaps.
First Element: ~a
Last Element: ~a"
            num-swaps (nth 0 lst) (nth (- lst-len 1) lst))))
