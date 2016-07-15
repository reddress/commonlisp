(in-package :hc)

(defparameter *notes-cat-db* (make-hash-table)
  "Storage for categories")

(defparameter *content-folder* (if (equal (subseq (machine-instance) 7 11) "asus")
                                   "/home/heitor/notes/"
                                   "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\notes\\"))

(defun add-brs (lst)
  (if (null lst)
      '()
      (cons (car lst) (cons '(:br) (add-brs (cdr lst))))))

(defun add-entry (title links categories content)
  ;; for each category add to *notes-cat-db*
  (dolist (category categories)
    (let* ((cat-list (gethash category *notes-cat-db*))
           (link-list (mapcar #'(lambda (link) `(:a :href ,link ,link)) links))
           (link-list-with-brs (add-brs link-list))
           (all-content `(:article
                          (:hr)
                          (:h2 ,title)
                          ,@link-list-with-brs
                          (:pre ,content))))
      (if cat-list
          (push all-content (gethash category *notes-cat-db*))
          (setf (gethash category *notes-cat-db*) (list all-content))))))

;;; TESTING
;; (setf *notes-cat-db* (make-hash-table))
;; (apply #'add-entry '("title" "link" (cat-1 cat-2) "pre block"))
;; (add-entry "title" "link" '(cat-1 cat-2) "pre block")

(defun read-content ()
  (setf *notes-cat-db* (make-hash-table))
  (with-open-file (in (concatenate 'string *content-folder* "content.lisp"))
    (let ((article-list (read in)))
      (dolist (article article-list)
        (apply #'add-entry article)))))
  
(defun create-page ()
  (let* ((page '(:html
                 :lang "en"
                 (:head
                  (:meta :charset "utf-8")
                  (:base :target "_blank")
                  (:title "Notes"))))                 
         (cat-keys (loop for k being the hash-keys in *notes-cat-db* using (hash-value v)
                      collecting k))
         (cat-keys-ordered (sort cat-keys #'string<=))
         (content '()))
    (dolist (cat cat-keys-ordered)
      (setf content (append content (list `(:a :href ,(string-downcase (concatenate 'string "#" (string cat))) ,(string-downcase (string cat))) '(:br)))))
    (dolist (cat cat-keys-ordered)
      (setf content (append content (list '(:hr) `(:h1 :id ,(string-downcase (string cat)) ,(string-downcase (string cat)))) (reverse (gethash cat *notes-cat-db*)))))
    (append page (list `(:body ,@content)))))

(defmacro generate-page ()
  (read-content)
  `(with-html-to-file (,(concatenate 'string *content-folder* "index.html")) ;; :pretty nil)
       (html
        ,(create-page))))
