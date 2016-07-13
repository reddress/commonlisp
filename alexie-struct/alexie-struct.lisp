;;;; Double-entry accounting

;;; Structures
(defconstruct account-type name sign)
(defconstruct account name type)
(defconstruct transaction date name amount debit credit)

(defvar *account-types* '())
(defvar *accounts* '())
(defvar *transactions* '())

(defun add-account-type (name sign)
  (if (get-account-type-sign name)
      (error "Account type already exists")
      (push (construct-account-type name sign) *account-types*)))

(defun get-account-type-sign (name)
  (dolist (account-type *account-types*)
    (if (equal (account-type-name account-type) name)
        (return-from get-account-type-sign (account-type-sign account-type)))))

(defun add-account (name type)
  (if (get-account-type-sign type)
      (if (get-account-sign name)
          (error "Account already exists")
          (push (construct-account name type) *accounts*))
      (error "Account type not registered")))

(defun get-account-sign (name)
  (dolist (account *accounts*)
    (if (equal (account-name account) name)
        (return-from get-account-sign (get-account-type-sign (account-type account))))))

(defun add-transaction (date name amount debit credit)
  (if (and (get-account-sign debit)
           (get-account-sign credit))
      (push (construct-transaction date name amount debit credit) *transactions*)
      (error "Account(s) not registered")))



(defun setup-basic-accounts ()
  (add-account-type 'asset 1)
  (add-account-type 'liability -1)
  (add-account-type 'expense 1)
  (add-account-type 'income -1)
  (add-account-type 'equity -1)

  (add-account 'open 'equity)
  (add-account 'sal 'income)
  (add-account 'chk 'asset)
  (add-account 'sav 'asset)
  (add-account 'wal 'asset)
  (add-account 'home 'expense)
  (add-account 'groc 'expense))


;;; File I/O

(defun save-file (object filename)
  (with-open-file (out filename
                       :direction :output
                       :if-exists :supersede)
    (with-standard-io-syntax
      (print object out))))

(defun load-file (filename)
  (with-open-file (in filename)
    (read in)))
;;; 
(defun cd-windows ()
  (ext:cd "C:\\Users\\Heitor\\Desktop\\emacs-24.3\\bin\\commonlisp\\alexie-struct\\data\\"))

(defun save-db ()
  (cd-windows)
  (save-file *account-types* "account-types.db")
  (save-file *accounts* "accounts.db")
  (save-file *transactions* "transactions.db")
  t)

(defun load-db ()
  (cd-windows)
  (setf *account-types* (load-file "account-types.db"))
  (setf *accounts* (load-file "accounts.db"))
  (setf *transactions* (load-file "transactions.db"))
  t)

(defun filter-transactions-by-account-name (name)
  (remove-if-not
   #'(lambda (tr) (or (equal (transaction-debit tr) name)
                      (equal (transaction-credit tr) name)))
   *transactions*))

(defun balances (transactions)
  ;; for each account, set to zero
  ;; dolist tr transactions
  ;; add/subtract
  transactions)
