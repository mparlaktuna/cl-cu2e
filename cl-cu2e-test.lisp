(in-package :cl-user)
(defpackage cl-cu2e-test
  (:use :cl
        :prove :cl-cu2e))
        
(in-package :cl-cu2e-test)

(plan 3)

(let ((vec (make-vec2 1 2))
      (a (make-aabb (make-vec2 1 2) (make-vec2 3 4)))
      (b (make-aabb (make-vec2 3 5) (make-vec2 6 7)))
      (c1 (make-circle 1 (make-vec2 1 2)))
      (c2 (make-circle 1 (make-vec2 4 5))))
  (ok (AABBvsAABB a b))
  (ok (circle-intersect-p c1 c2)))

(isnt 1 #\1)

(finalize)
