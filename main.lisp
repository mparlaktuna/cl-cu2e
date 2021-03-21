(in-package :cl-cu2e)


;; (defmethod sat-x ((a vec2) (b vec2))
;;   (> (vec2-x a) (vec2-x b)))

;; (defmethod sat-y ((a vec2) (b vec2))
;;   (> (vec2-y a) (vec2-y b)))

(defclass aabb ()
  ((min :initarg :min :accessor aabb-min)
   (max :initarg :max :accessor aabb-max)))

(defmethod make-aabb ((vec-min vec2) (vec-max vec2))
  (make-instance 'AABB :min vec-min :max vec-max))   

;; (defmethod aabb-intersect-p ((a aabb) (b aabb)))
;; (defmethod AABBvsAABB ((a AABB) (b AABB))
;;   "fix there is a problem inverse of example function is not correct"
;;   (let ((a-max (aabb-max a))
;; 	(a-min (aabb-min a))
;;         (b-max (aabb-max b))
;;         (b-min (aabb-min b)))
;;     (not (and (or (sat-x a-max b-min) (sat-x b-max a-min))
;; 	      (or (sat-y a-max b-min) (sat-y b-max a-min))))))
       
(defclass circle ()
  ((radius :initarg :radius :accessor circle-radius)
   (center :initarg :center :accessor circle-center)))

(defmethod make-circle (radius (center vec2))
  (make-instance 'circle :radius radius :center center))   

(defmethod circle-intersect-p ((a circle) (b circle))
  (let* ((total-r (expt (+ (circle-radius a) (circle-radius b)) 2))
	(dist-vec (v- (circle-center a) (circle-center b)))
	(dist (+ (expt (vx dist-vec) 2) (expt (vy dist-vec) 2))))
    (> total-r dist)))

