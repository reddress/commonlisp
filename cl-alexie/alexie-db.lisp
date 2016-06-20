;;;; call before saving or loading db
(defun cd-windows ()
  (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\cl-alexie\\data\\"))

(defvar *account-type-db* '())
(defvar *account-db* '())
(defvar *transaction-db* '())

(defun make-account-type (type sign)
  (list :type type
        :sign sign))

(defun make-account (name type)
  (list :name name
        :type type
        :balance 0))

(defun make-transaction (desc amount debit credit
                         &optional (date (get-universal-time))
                           (id (+ (length *transaction-db*) 1)))
  (list :desc desc
        :amount amount
        :debit debit
        :credit credit
        :date date
        :id id))

(defun add-account-type (type sign)
  (push (make-account-type type sign)
        *account-type-db*))

(defun add-account (name type)
  (push (make-account name type)
        *account-db*))

(defun get-account (name)
  (car (match :name name *account-db*)))

(defun get-account-type (type)
  (car (match :type type *account-type-db*)))

(defun get-account-sign (name)
  (let* ((account (get-account name))
         (account-type (get-account-type (getf account :type)))
         (sign (getf account-type :sign)))
    sign))

;; (match :type 'asset *account-db*)
;; (match :credit 'open *transaction-db*)
(defun match (kw value db)
  (remove-if-not (lambda (elem) (eql (getf elem kw) value)) db))

(defun add-transaction (desc amount debit credit &optional (date (get-universal-time)) (id (+ (length *transaction-db*) 1)))
  (push (make-transaction desc amount debit credit date id)
        *transaction-db*)
  ;; update balances
  (let ((debit-account (get-account debit))
        (credit-account (get-account credit))
        (debit-sign (get-account-sign debit))
        (credit-sign (get-account-sign credit)))
    (incf (getf debit-account :balance) (* debit-sign amount))
    (decf (getf credit-account :balance) (* credit-sign amount))))
    
(defun save-dbs (filename)
  (with-open-file (out filename
                       :direction :output
                       :if-exists :supersede)
    (with-standard-io-syntax
      (print *account-type-db* out)
      (print *account-db* out)
      (print *transaction-db* out))))

(defun load-dbs (filename)
  (with-open-file (in filename)
    (with-standard-io-syntax
      (setf *account-type-db* (read in))
      (setf *account-db* (read in))
      (setf *transaction-db* (read in)))))
            
;;;; create account-types
(defun setup-default-account-types ()
  (add-account-type 'asset 1)
  (add-account-type 'liability -1)
  (add-account-type 'expense 1)
  (add-account-type 'income -1)
  (add-account-type 'equity -1))

(defun setup-default-accounts ()
  (add-account 'bank 'asset)
  (add-account 'card 'liability)
  (add-account 'exp 'expense)
  (add-account 'inc 'income)
  (add-account 'open 'equity))

;; CL Cookbook
(defun join-string-list (string-list)
  (format nil "~{~A ~}" string-list))

(defun ends-in-period (sym)
  (let ((s (string sym)))
    s))  ; incomplete

;;; type even less than normal, interpreting symbols without quotes
(defmacro tr (&rest descs)
  (let ((desc-string (join-string-list desc)))
    `(add-transaction ,desc-string ,amt ',dr ',cr)))

(defun show-balances ()
  (dolist (acct *account-db*)
    (format t "~A: ~A~%" (getf acct :name) (getf acct :balance))))

(defun select-by-artist (artist)
  (remove-if-not
   #'(lambda (cd) (equal (getf cd :artist) artist))
   *db*))

(defun title-selector (title)
  #'(lambda (cd) (equal (getf cd :title) title)))

;;; a more general selector

(defun select (selector-fn)
  (remove-if-not selector-fn *db*))

;;; #' is used in the call to select

;; (select #'(lambda (cd) (equal (getf cd :artist) "Laura Pausini")))
;; (select (title-selector "Doomsday Machine"))

;; (select (where-fn :rating 9))


(defun where-fn (&key title artist rating (ripped nil ripped-p))
  #'(lambda (cd)
      (and
       (if title (equal (getf cd :title) title) t)
       (if artist (equal (getf cd :artist) artist) t)
       (if rating (equal (getf cd :rating) rating) t)
       (if ripped-p (equal (getf cd :ripped) ripped) t))))

;; (update (where-fn :artist "Nobuo Uematsu") :rating 10)

(defun update (selector-fn &key title artist rating (ripped nil ripped-p))
  (setf *db*
        (mapcar
         #'(lambda (row)
             (when (funcall selector-fn row)
               (if title (setf (getf row :title) title))
               (if artist (setf (getf row :artist) artist))
               (if rating (setf (getf row :rating) rating))
               (if ripped-p (setf (getf row :ripped) ripped)))
             row) *db*)))

;; (delete-rows (where-fn :artist "Michael Jackson"))

(defun delete-rows (selector-fn)
  (setf *db* (remove-if selector-fn *db*)))

(defun make-comparison-expr (field value)
  `(equal (getf cd ,field) ,value))

(defun make-comparisons-list (fields)
  (loop while fields
     collecting (make-comparison-expr (pop fields) (pop fields))))

(defmacro where (&rest clauses)
  `#'(lambda (cd) (and ,@(make-comparisons-list clauses))))

