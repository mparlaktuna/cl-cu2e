(cl:in-package #:asdf-user)

(require :alexandria)

(defsystem :cl-cu2e
  :description ""
  :version "0.0.1"
  :author "Mustafa Parlaktuna <mparlaktuna@gmail.com>"
  :license "GPLv3"
  :serial t
  :depends-on (:alexandria)
  :components ((:file "package")
	       (:file "main")))
 
               
               

