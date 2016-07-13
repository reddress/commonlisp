(defconstruct hc-tree data left right)

(defparameter *tree* (construct-hc-tree 0 nil nil))

(hc-tree-left *tree*)

(setf (hc-tree-left *tree*) '(9 nil nil))

(setf (hc-tree-right *tree*) (construct-hc-tree 39 nil nil))
