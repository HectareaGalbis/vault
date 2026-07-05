
(defsystem "vault"
  :author "Héctor Galbis Sanchis"
  :description "A vault of functions and variables"
  :license "MIT"
  :components ((:module "src"
                :serial t
                :components ((:file "package")
                             (:file "vault")))))

;; (defsystem "vault/docs"
;;   :author "Héctor Galbis Sanchis"
;;   :description "Documentation of vault."
;;   :license "MIT"
;;   :depends-on ("vault")
;;   :defsystem-depends-on ("adp-github")
;;   :class :adp-github
;;   :components ((:module "scribble"
;;                 :components ((:file "package")
;;                              (:scribble "README")))))
