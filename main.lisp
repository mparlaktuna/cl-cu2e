(in-package :cl-cu2e)


;; (defmethod sat-x ((a vec2) (b vec2))
;;   (> (vec2-x a) (vec2-x b)))

;; (defmethod sat-y ((a vec2) (b vec2))
;;   (> (vec2-y a) (vec2-y b)))

(defclass model ()
  ((pos :initarg :pos :accessor model-pos)
   (shape :initarg :shape :accessor model-shape)))

(defclass visual-model (model) ())

(defmethod make-visual-model ((pos vec2) (shape shape))
  (make-instance 'visual-model :pos pos :shape shape))
  
(defclass physical-model (model) ())

(defmethod make-physical-model ((pos vec2) (shape shape))
  (make-instance 'visual-model :pos pos :shape shape))

(defclass shape () ())

(defclass circle (shape)
  ((radius :initarg :radius :accessor circle-radius)))

(defun make-circle (rad)
  (make-instance 'circle :radius rad))
  
(defclass object ()
  ((physical :initarg :physical :accessor object-physical)
   (visual :initarg :visual :accessor object-visual)))

(defmethod make-object ((phy physical-model) (vis visual-model))
  (make-instance 'object :physical phy :visual vis))

;; (defclass aabb ()
;;   ((min :initarg :min :accessor aabb-min)
;;    (max :initarg :max :accessor aabb-max)))

;; (defmethod make-aabb ((vec-min vec2) (vec-max vec2))
;;   (make-instance 'AABB :min vec-min :max vec-max))   

;; (defmethod aabb-intersect-p ((a aabb) (b aabb)))
;; (defmethod AABBvsAABB ((a AABB) (b AABB))
;;   "fix there is a problem inverse of example function is not correct"
;;   (let ((a-max (aabb-max a))
;; 	(a-min (aabb-min a))
;;         (b-max (aabb-max b))
;;         (b-min (aabb-min b)))
;;     (not (and (or (sat-x a-max b-min) (sat-x b-max a-min))
;; 	      (or (sat-y a-max b-min) (sat-y b-max a-min))))))
       

;; (defmethod make-circle (radius (center vec2))
;;   (make-instance 'circle :radius radius :center center))   

;; (defmethod circle-intersect-p ((a circle) (b circle))
;;   (let* ((total-r (expt (+ (circle-radius a) (circle-radius b)) 2))
;; 	(dist-vec (v- (circle-center a) (circle-center b)))
;; 	(dist (+ (expt (vx dist-vec) 2) (expt (vy dist-vec) 2))))
;;     (> total-r dist)))


(defclass scene ()
  ((models :initform nil :accessor scene-models)
   (dims :initform nil :reader scene-dims)))
  
(defclass scene2d (scene)
  ((dims :initform 2)))

(defmethod add-object ((scene scene) (object object))
  (push object (scene-models scene)))
