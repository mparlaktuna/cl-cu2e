(in-package :cl-user)
(defpackage cl-cu2e-test
  (:use :cl
        :prove :cl-cu2e 3d-vectors))
        
(in-package :cl-cu2e-test)

(plan 4)

(is-type (make-aabb (vec 1 2) (vec 3 4)) 'cl-cu2e::aabb)
(is-type (make-circle 5 (vec 1 2)) 'cl-cu2e::circle)
(is 5.0 (vlength (vec 3 4)))

(ok (circle-intersect-p (make-circle 2 (vec 0 0)) (make-circle 2 (vec 0 1))))
(ok (circle-intersect-p (make-circle 2 (vec 0 0)) (make-circle 2 (vec 0 4.5))))

(finalize)
