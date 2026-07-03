
(defpackage #:fvault
  (:use #:cl #:alexandria)
  (:export #:defvault #:vaultp
           #:define-vault-function #:vault-function-p #:vault-function #:vault-funcall #:vault-apply
           #:define-vault-variable #:vault-variable-p #:vault-variable))
