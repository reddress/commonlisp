;;;; JavaScript implementation

(defconstant +JS-VER+ "
var accountTypeDB = {};
var accountDB = {};
var transactionDB = [];

function addAccountType(type, sign) {
  // accountTypeDB.push({ type: type, sign: sign });
  accountTypeDB[type] = sign;
}

function addAccount(name, type) {
  // accountDB.push({ name: name, type: type, balance: 0 });
  accountDB[name] = { type: type,
                      balance: 0 };
}

function addTransaction(desc, amount, debit, credit, date, id) {
  date = date || new Date().getTime();
  id = id || transactionDB.length + 1;
  var debitAccount = accountDB[debit];
  var creditAccount = accountDB[credit];
  debitAccount.balance += amount * accountTypeDB[debitAccount.type];
  creditAccount.balance -= amount * accountTypeDB[creditAccount.type];
}

addAccountType('asset', 1);
addAccountType('income', -1);

addAccount('bank', 'asset');
addAccount('job', 'income');

addTransaction('sal', 1000, 'bank', 'job');
")

(defvar *types* '())
(defvar *accounts* '())
(defvar *transactions* '())

;; (defconstruct type sign)
;; (defconstruct account type)
(defconstruct transaction desc amount debit credit)

(defun add-type (id sign)
  (setf (getf *types* id) sign))

(defun get-type-sign (id)
  (getf *types* id))

(defun add-account (id type)
  (setf (getf *accounts* id) type))

(defun get-account-type (id)
  (getf *accounts* id))

(defun get-account-sign (id)
  (let ((type (get-account-type id)))
    (get-type-sign type)))

(defun add-transaction (desc amount debit credit)
  (push (construct-transaction desc amount debit credit) *transactions*))

(defun filter-transactions (id)
  (remove-if-not
   (lambda (tr) (or (eql (transaction-debit tr) id)
                    (eql (transaction-credit tr) id)))
   *transactions*))

(defun balance (id)
  (let ((bal 0)
        (trs (filter-transactions id))
        (sign (get-account-sign id)))
    (dolist (tr trs)
      (if (eql (transaction-debit tr) id)
          (incf bal (* (transaction-amount tr) sign))
          (decf bal (* (transaction-amount tr) sign))))
    bal))

(defun balances (transactions)
  (let ((bals '()))
    ;; iterate through all transactions
    (dolist (tr transactions)
      (let* ((debit-id (transaction-debit tr))
             (credit-id (transaction-credit tr))
             (debit-sign (get-account-sign debit-id))
             (credit-sign (get-account-sign credit-id))
             (amount (transaction-amount tr)))
        ;; increment debits
        (if (getf bals debit-id)
            (incf (getf bals debit-id) (* debit-sign amount))
            (setf (getf bals debit-id) (* debit-sign amount)))
        ;; decrement credits
        (if (getf bals credit-id)
            (incf (getf bals credit-id) (* credit-sign (- amount)))
            (setf (getf bals credit-id) (* credit-sign (- amount))))))
    bals))

(defun save-dbs (filename)
  (with-open-file (out filename
                       :direction :output
                       :if-exists :supersede)
    (with-standard-io-syntax
      (print *types* out)
      (print *accounts* out)
      (print *transactions* out))))

(defun load-dbs (filename)
  (with-open-file (in filename)
    (with-standard-io-syntax
      (setf *types* (read in))
      (setf *accounts* (read in))
      (setf *transactions* (read in)))))

;;;; Initialize data

(defun init ()
  (add-type :asset 1)
  (add-type :liability -1)
  (add-type :expense 1)
  (add-type :income -1)
  (add-type :equity -1)

  (add-account :sal :income)
  (add-account :wal :asset)
  (add-account :chk :asset)
  (add-account :sav :asset)
  (add-account :groc :expense)

  (add-transaction "Salary"      2000 :chk :sal)
  (add-transaction "Withdrawal"   100 :wal :chk)
  (add-transaction "Beans"         10 :groc :wal))
