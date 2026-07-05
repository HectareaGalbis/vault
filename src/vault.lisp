
(in-package #:vault)

(eval-when (:compile-toplevel :load-toplevel :execute)

  (defconstant +vault-prop+ 'vault)

  (defun vault-object (vault)
    "Retrieve the vault object."
    (get vault +vault-prop+))

  (defun (setf vault-object) (object vault)
    "Set the vault object."
    (setf (get vault +vault-prop+) object))

  (defun vaultp (vault)
    "Check if a symbol denotes a vault."
    (check-type vault symbol)
    (and (vault-object vault) t))

  (defun check-vault (vault)
    "Check if VAULT denotes a vault."
    (unless (vaultp vault)
      (error "Not a vault: ~s" vault)))

  (defun vault-function-object (vault)
    "Retrieve the function object of a vault."
    (check-vault vault)
    (car (vault-object vault)))
  
  (defun vault-function-p (vault name)
    "Check if NAME denotes a function in VAULT."
    (check-vault vault)
    (check-type name symbol)
    (nth-value 1 (gethash name (vault-function-object vault))))

  (defun check-vault-function (vault name)
    "Check if NAME denotes a function in VAULT."
    (check-vault vault)
    (unless (and (symbolp name) (vault-function-p vault name))
      (error "Not a vault function from the vault ~a: ~s" vault name)))

  (defun vault-function (vault name)
    "Retrieve the function NAME from VAULT."
    (check-vault vault)
    (check-vault-function vault name)
    (values (gethash name (vault-function-object vault))))

  (defun (setf vault-function) (new-function vault name)
    "Insert or update a function with the name NAME in VAULT."
    (check-type new-function function)
    (check-vault vault)
    (check-type name symbol)
    (setf (gethash name (vault-function-object vault)) new-function))

  (defun vault-funcall (vault name &rest args)
    "Call the function NAME from VAULT with ARGS."
    (check-vault vault)
    (check-vault-function vault name)
    (apply (vault-function vault name) args))

  (defun vault-apply (vault name &rest args)
    "Apply the function NAME from VAULT with ARGS."
    (check-vault vault)
    (check-vault-function vault name)
    (apply #'apply (vault-function vault name) args))

  (defun vault-variable-object (vault)
    "Retrieve the variable object of a vault."
    (check-vault vault)
    (cdr (vault-object vault)))
  
  (defun vault-variable-p (vault name)
    "Check if NAME denotes a variable in VAULT."
    (check-vault vault)
    (check-type name symbol)
    (nth-value 1 (gethash name (vault-variable-object vault))))

  (defun check-vault-variable (vault name)
    "Check if NAME denotes a variable in VAULT."
    (check-vault vault)
    (unless (and (symbolp name) (vault-variable-p vault name))
      (error "Not a vault variable from the vault ~a: ~s" vault name)))

  (defun vault-variable (vault name)
    "Retrieve the value of the variable NAME from VAULT."
    (check-vault vault)
    (check-vault-variable vault name)
    (values (gethash name (vault-variable-object vault))))

  (defun (setf vault-variable) (new-value vault name)
    "Insert or update a variable with the name NAME in VAULT."
    (check-vault vault)
    (check-type name symbol)
    (setf (gethash name (vault-variable-object vault)) new-value)))

(defun ensure-vault (vault)
  "If VAULT is not a vault, defines a new one with that name."
  (check-type vault symbol)
  (unless (vaultp vault)
    (setf (vault-object vault) (cons (make-hash-table :test 'eq)
                                     (make-hash-table :test 'eq))))
  vault)

(defmacro defvault (vault)
  "Define a new vault denoted by VAULT if it is not defined yet. 
If used at top level the vault will be defined at compile time."
  (check-type vault symbol)
  `(eval-when (:compile-toplevel :load-toplevel :execute)
     (ensure-vault ',vault)))

(defmacro define-vault-function (vault name (&rest args) &body body)
  "Define and insert a function into VAULT. If used at top level the function will be defined at
compile time. NAME must be a symbol denoting the new function. ARGS is an ordinary lambda list."
  (check-vault vault)
  (check-type name symbol)
  `(eval-when (:compile-toplevel :load-toplevel :execute)
     (setf (vault-function ',vault ',name) (lambda ,args ,@body))
     ',name))

(defmacro define-vault-variable (vault name value)
  "Define and insert a variable into VAULT. If used at top level the variable will be defined at
compile time. NAME must be a symbol denoting the new variable."
  (check-vault vault)
  (check-type name symbol)
  `(eval-when (:compile-toplevel :load-toplevel :execute)
     (setf (vault-variable ',vault ',name) ,value)
     ',name))
