;; p. 267, 295

(setq *cont* #'identity)
(defconstant failsym '@)

(defmacro =defun (name parms &body body)
  (let ((f (intern (concatenate 'string "=" (symbol-name name)))))
    `(progn
       (defmacro ,name ,parms
         `(,',f *cont* ,,@parms))
       (defun ,f (*cont* ,@parms) ,@body))))

(defmacro =bind (parms expr &body body)
  `(let ((*cont* #'(lambda ,parms ,@body))) ,expr))

(defmacro =values (&rest retvals)
  `(funcall *cont* ,@retvals))

;;; p. 324

(defmacro with-inference (query &body body)
  `(progn
     (setq *paths* nil)
     (=bind (binds) (prove-query ',(rep_ query) nil)
            (let ,(mapcar #'(lambda (v)
                              `(,v (fullbind ',v binds)))
                          (vars-in query #'atom))
              ,@body
              (fail)))))

(defun rep_ (x)
  (if (atom x)
      (if (eq x '_) (gensym "?") x)
      (cons (rep_ (car x)) (rep_ (cdr x)))))

(defun fullbind (x b)
  (cond ((varsym? x) (aif2 (binding x b)
                           (fullbind it b)
                           (gensym)))
        ((atom x) x)
        (t (cons (fullbind (car x) b)
                 (fullbind (cdr x) b)))))

(defun varsym? (x)
  (and (symbolp x) (eq (char (symbol-name x) 0) #\?)))

(defun binding (x binds)
  (labels ((recbind (x binds)
             (aif (assoc x binds)
                  (or (recbind (cdr it) binds)
                      it))))
    (let ((b (recbind x binds)))
      (values (cdr b) b))))

;;; p. 191

(defmacro aif (test-form then-form &optional else-form)
  `(let ((it ,test-form))
     (if it ,then-form ,else-form)))

;;; p. 198 Anaphoric macros

(defmacro aif2 (test &optional then else)
  (let ((win (gensym)))
    `(multiple-value-bind (it ,win) ,test
       (if (or it ,win) ,then ,else))))

(defmacro acond2 (&rest clauses)
  (if (null clauses)
      nil
      (let ((cl1 (car clauses))
            (val (gensym))
            (win (gensym)))
        `(multiple-value-bind (,val ,win) ,(car cl1)
           (if (or ,val ,win)
               (let ((it ,val)) ,@(cdr cl1))
               (acond2 ,@(cdr clauses)))))))

;;; p. 326

(=defun prove-query (expr binds)
        (case (car expr)
          (and (prove-and (cdr expr) binds))
          (or (prove-or (cdr expr) binds))
          (not (prove-not (cadr expr) binds))
          (t (prove-simple expr binds))))

(=defun prove-and (clauses binds)
        (if (null clauses)
            (=values binds)
            (=bind (binds) (prove-query (car clauses) binds)
                   (prove-and (cdr clauses) binds))))

(=defun prove-or (clauses binds)
        (choose-bind c clauses
                     (prove-query c binds)))

(=defun prove-not (expr binds)
        (let ((save-paths *paths*))
          (setq *paths* nil)
          (choose (=bind (b) (prove-query expr binds)
                         (setq *paths* save-paths)
                         (fail))
                  (progn
                    (setq *paths* save-paths)
                    (=values binds)))))

(=defun prove-simple (query binds)
        (choose-bind r *rlist*
                     (implies r query binds)))

;;; p. 170

(define-modify-macro conc1f (obj)
  (lambda (place obj)
    (nconc place (list obj))))

;;; p. 240

(defun vars-in (expr &optional (atom? #'atom))
  (if (funcall atom? expr)
      (if (var? expr) (list expr))
      (union (vars-in (car expr) atom?)
             (vars-in (cdr expr) atom?))))

(defun var? (x)
  (and (symbolp x) (eq (char (symbol-name x) 0) #\?)))

;;; p. 58

(defun mkstr (&rest args)
  (with-output-to-string (s)
    (dolist (a args) (princ a s))))

(defun symb (&rest args)
  (values (intern (apply #'mkstr args))))

;;; p. 239

(defun match (x y &optional binds)
  (acond2
   ((or (eql x y) (eql x '_) (eql y '_)) (values binds t))
   ((binding x binds) (match it y binds))
   ((binding y binds) (match x it binds))
   ((varsym? x) (values (cons (cons x y) binds) t))
   ((varsym? y) (values (cons (cons y x) binds) t))
   ((and (consp x) (consp y) (match (car x) (car y) binds))
    (match (cdr x) (cdr y) it))
   (t (values nil nil))))

;;; p. 295

(defmacro choose-bind (var choices &body body)
  `(cb #'(lambda (,var) ,@body) ,choices))

(defun cb (fn choices)
  (if choices
      (progn
        (if (cdr choices)
            (push #'(lambda () (cb fn (cdr choices)))
                  *paths*))
        (funcall fn (car choices)))
      (fail)))

(defun fail ()
  (if *paths*
      (funcall (pop *paths*))
      failsym))

;;; p. 327

(defparameter *rlist* nil)

(defmacro <- (con &rest ant)
  (let ((ant (if (= (length ant) 1)
                 (car ant)
                 `(and ,@ant))))
    `(length (conc1f *rlist* (rep_ (cons ',ant ',con))))))

(=defun implies (r query binds)
        (let ((r2 (change-vars r)))
          (aif2 (match query (cdr r2) binds)
                (prove-query (car r2) it)
                (fail))))

(defun change-vars (r)
  (sublis (mapcar #'(lambda (v)
                      (cons v (symb '? (gensym))))
                  (vars-in r #'atom))
          r))

;;; p. 329 Sec. 24.3 Rules

(<- (painter ?x) (hungry ?x)
    (smells-of ?x turpentine))

(<- (hungry ?x) (or (gaunt ?x) (eats-ravenously ?x)))

(<- (gaunt raoul))
(<- (smells-of raoul turpentine))
(<- (painter rubens))

(with-inference (painter ?x)
  (print ?x))
