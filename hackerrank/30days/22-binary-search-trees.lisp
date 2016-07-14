;; Submitted a JavaScript solution, shown below

(defun node (data)
  (list data nil nil))

;; BST = (root <a node> 

(defun insert (tree data)
  (cond ((null tree)
         (node data))
        ((<= data (car tree))
         (if (cadr tree)
             (list (car tree) (insert (cadr tree) data) (caddr tree))
             (list (car tree) (node data) (caddr tree))))
        (t
         (if (caddr tree)
             (list (car tree) (cadr tree) (insert (caddr tree) data))
             (list (car tree) (caddr tree) (node data))))))
         
(defparameter *tree*
  (insert (insert (insert (insert (insert (insert (insert nil 3) 5) 2) 1) 4) 6) 7))

(defun height (tree)
  (if (null tree) 0
      (max (if (cadr tree)
               (+ 1 (height (cadr tree)))
               0)
           (if (caddr tree)
               (+ 1 (height (caddr tree)))
               0))))

(defvar *submitted* "
function Node(data) {
    this.data = data; this.left = null; this.right = null;
}; // End of function Node

function BinarySearchTree() {
    this.insert = function(root, data) {
        if (root === null) {
            this.root = new Node(data);
            return this.root;
        }
        if (data <= root.data) {
            if (root.left) {
                this.insert(root.left, data);
            } else {
                root.left = new Node(data);
            }
        } else {
            if (root.right) {
                this.insert(root.right, data);
            } else {
                root.right = new Node(data);
            }
        }
        
        return this.root;
    };

  // Start of function getHeight
    this.getHeight = function(root) {
      if (root === null) {
        return -1;
      }
      return Math.max(1 + this.getHeight(root.left), 1 + this.getHeight(root.right));
    }


// version 2
/*
      if (root === null) {
        return 0;
      }
      return Math.max(root.left ? (1 + this.getHeight(root.left)) : 0, 
                      root.right ? (1 + this.getHeight(root.right)) : 0);
*/

}

 var tree = new BinarySearchTree();
    var root = null;
    
    var values = [1,3,5,2,4,6,8,9,10];
    
    for (var i = 1; i < values.length; i++) {
        root = tree.insert(root, values[i]);
    }
    
    console.log(tree.getHeight(root));
")
