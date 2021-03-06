(cl:in-package #:asdf-user)

(require :alexandria)
(require :prove)
(require :3d-vectors)
(require :3d-matrices)
(require :mcclim)
(require :cl-hooks)
(require :iterate)

(defsystem :cl-cu2e
  :description ""
  :version "0.0.1"
  :author "Mustafa Parlaktuna <mparlaktuna@gmail.com>"
  :license "GPLv3"
  :serial t
  :depends-on (:alexandria :3d-vectors :3d-matrices :clim :cl-hooks :iterate)
  :in-order-to ((test-op (test-op cl-cu2e-test)))
  :components ((:file "package")
	       (:file "main")
               (:file "ui")))
 
(defsystem cl-cu2e-test
  :depends-on (:cl-cu2e
               :prove)
  :defsystem-depends-on (:prove-asdf)
  :components
  ((:test-file "cl-cu2e-test"))
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run) :prove) c)))

               
               

