;;;; Number and Problem description
;;;; 61 Map Construction

;;;; using CLISP
(if (string= "heitor-asus" (subseq (machine-instance) 0 11))  ; ubuntu
    (ext:cd "/home/heitor/commonlisp/lib/")
    ;;;; else, in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\lib\\"))

;;;; load unit-test framework
(load "pcl-unit-test.lisp")

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp :pcl.unit-test))
(in-package :four-cl)

;;;; __ gets replaced by SOLUTION
;;
;; (deftest PROBLEM-NAME
;;     ((TEST)
;;      (equal (__ n) m)  ; example
;;      ...
;;      (TEST)
;;      (TEST)*)
;;   SOLUTION)

;; Run tests
;; (PROBLEM-NAME)

;;;; UPDATE file problem-list.txt after solving

(deftest map-construction
    ((let ((hash-1 (__ '(:a :b :c) '(1 2 3))))
       (and (= (gethash :a hash-1) 1)
            (= (gethash :b hash-1) 2)
            (= (gethash :c hash-1) 3)))
     (let ((hash-2 (__ '(1 2 3 4) '("one" "two" "three"))))
       (and (string= (gethash 1 hash-2) "one")
            (string= (gethash 2 hash-2) "two")
            (string= (gethash 3 hash-2) "three")))
     (let ((hash-3 (__ '(:foo :bar) '("foo" "bar" "baz"))))
       (and (string= (gethash :foo hash-3) "foo")
            (string= (gethash :bar hash-3) "bar"))))
  construct-map)

(defun construct-map (keys vals)
  (let ((result (make-hash-table)))
    (labels ((construct-map-helper (keys vals)
               (if (or (null keys) (null vals))
                   result
                   (progn 
                     (setf (gethash (car keys) result) (car vals))
                     (construct-map-helper 
                      (cdr keys)
                      (cdr vals))))))
      (construct-map-helper keys vals))))

