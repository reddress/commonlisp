;;;; 28 Flatten a Sequence

;;;; full package name :io.github.heitorchang.four-cl
(defpackage :four-cl
  (:use :common-lisp))
(in-package :four-cl)

(if (string= "heitor-asus" (subseq (machine-instance) 0 11))
    (ext:cd "/home/heitor/commonlisp/four-cl/")
    ;;;; else, using CLISP in Windows
    (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\four-cl\\"))

;;;; load unit-test framework
(load "unit-test.lisp")

;;;; UPDATE file problem-list.txt

(defproblem flatten-a-sequence
    ((equal (__ '((1 2) 3 (4 (5 6)))) '(1 2 3 4 5 6))
     (equal (__ '("a" ("b") "c")) '("a" "b" "c"))
     (equal (__ '((((:a))))) '(:a)))
  my-flatten)

;;; stuck for over an hour, the key breakthrough was removing a level
;;; of nesting by using append on a recursive call to my-flatten. If
;;; the head (first element) is an atom, simply cons it to the
;;; flattened rest.
;;; Otherwise, append the head (which may be another nested list, so
;;; call my-flatten on it) to the flattened rest.

(defun my-flatten (lst)
  (when lst
    (let ((head (car lst)))
      (if (atom head)
          (cons head (my-flatten (cdr lst)))
          (append (my-flatten head) (my-flatten (cdr lst)))))))


(defun flatten-a-nested (nested)
  (let ((head (car nested)))
    (if (listp head)
        (flatten-a-nested head)
        head)))

(defun remove-a-level (lst)
  (let ((head (car lst)))
    (if (listp head)
        (cons (car head) (cdr lst)))))

(defun remove-a-level-rec (arg)
  (when arg
    (if (listp arg)
        (let ((head (car arg)))
          (if (listp head)
              (cons (remove-a-level-rec (car head))
                    (remove-a-level-rec (cdr arg)))))
        arg)))

(defun remove-all-levels (lst)
  (if (listp lst)
      (when lst
        (let ((head (car lst)))
          (if (listp head)
              (remove-all-levels
               (cons (car head) (mapcar #'remove-all-levels (cdr head))))
              lst)))
      lst))

(defun by-case (lst)
  (when lst
    (if (atom lst)
        lst
        (if (atom (car lst))
            (cons (car lst) (by-case (cdr lst)))
            (cons (by-case (caar lst)) (by-case (cdr lst)))))))

(defun by-case-2 (lst)
  (when lst
    (if (atom (car lst))
        (cons (car lst) (by-case-2 (cdr lst)))
        (append (by-case-2 (car lst)) (by-case-2 (cdr lst))))))  ; victory
