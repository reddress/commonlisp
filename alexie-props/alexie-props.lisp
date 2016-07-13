;;; each account and type are a symbol

(setf (get 'asset 'sign) 1)
(setf (get 'liability 'sign) -1)
(setf (get 'expense 'sign) 1)
(setf (get 'income 'sign) -1)
(setf (get 'equity 'sign) -1)

(setf (get 'open 'type) 'equity)
(setf (get 'sal 'type) 'income)
(setf (get 'chk 'type) 'asset)
(setf (get 'wal 'type) 'asset)
(setf (get 'groc 'type) 'expense)
(setf (get 'home 'type) 'expense)

(defvar *transactions* '())

(defun get-account-sign (name)
  (get (get name 'type) 'sign))

(defun add-transaction (desc amount debit credit)
  (push (list desc amount debit credit) *transactions*))
      
