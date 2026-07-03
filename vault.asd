
(defsystem "vault"
  :author "Héctor Galbis Sanchis"
  :description "A vault of functions and variables"
  :license "MIT"
  :components ((:module "src"
                :components ((:file "package")
                             (:file "vault")))))
