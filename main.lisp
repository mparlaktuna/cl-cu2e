(in-package :cl-cu2e)

(defclass vec2 ()
  ((x :initarg :x :accessor vec2-x)
   (y :initarg :y :accessor vec2-y)))

(defun make-vec2 (x y)
  (make-instance 'vec2 :x x :y y))

(defmethod sat-x ((a vec2) (b vec2))
  (> (vec2-x a) (vec2-x b)))

(defmethod sat-y ((a vec2) (b vec2))
  (> (vec2-y a) (vec2-y b)))

(defclass AABB ()
  ((min :initarg :min :accessor aabb-min)
   (max :initarg :max :accessor aabb-max)))

(defun make-AABB (vec-min vec-max)
  (make-instance 'AABB :min vec-min :max vec-max))   

(defmethod AABBvsAABB ((a AABB) (b AABB))
  "fix there is a problem inverse of example function is not correct"
  (let ((a-max (aabb-max a))
	(a-min (aabb-min a))
        (b-max (aabb-max b))
        (b-min (aabb-min b)))
    (not (and (or (sat-x a-max b-min) (sat-x b-max a-min))
	      (or (sat-y a-max b-min) (sat-y b-max a-min))))))
       
(defclass circle ()
  ((radius :initarg :radius :accessor circle-radius)
   (center :initarg :center :accessor circle-center)))

(defun make-circle (radius center)
  (make-instance 'circle :radius radius :center center))   

(defmethod circle-intersect-p ((a circle) (b circle))
  (let ((total-r (+ (circle-radius a) (circle-radius b)))
	(x-dist (- (vec2-x (circle-center a)) (vec2-x (circle-center b))))
        (y-dist (- (vec2-y (circle-center a)) (vec2-y (circle-center b)))))
    (> (* total-r total-r) (+ (* x-dist x-dist) (* x-dist x-dist)))))

(let ((vec (make-vec2 1 2))
      (a (make-aabb (make-vec2 1 2) (make-vec2 3 4)))
      (b (make-aabb (make-vec2 3 5) (make-vec2 6 7)))
      (c1 (make-circle 1 (make-vec2 1 2)))
      (c2 (make-circle 1 (make-vec2 4 5))))
  (AABBvsAABB a b)
  (circle-intersect-p c1 c2))

