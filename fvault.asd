
(defsystem "fvault"
  :author "Héctor Galbis Sanchis"
  :description "A vault of functions"
  :license "MIT"
  :depends-on ("alexandria")
  :components ((:module "src"
                :components ((:file "package")
                             (:file "fvault")))))
