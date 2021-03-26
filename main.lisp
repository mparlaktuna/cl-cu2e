(in-package :cl-cu2e)

(defclass model ()
  ((pos :initarg :pos :accessor model-pos)
   (shape :initarg :shape :accessor model-shape)))

(defclass visual-model (model) ())

(defmethod make-visual-model ((pos vec2) (shape shape))
  (make-instance 'visual-model :pos pos :shape shape))
  
(defclass physical-model (model) ())

(defmethod make-physical-model ((pos vec2) (shape shape))
  (make-instance 'physical-model :pos pos :shape shape))

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

(defclass scene ()
  ((name :initarg :name :accessor scene-name)
   (models :initform nil :accessor scene-models)
   (dt :initarg dt :accessor scene-dt)
   (thread :initform nil :accessor scene-thread)
   (continue-thread :initform nil :accessor continue-thread)
   (scene-thread-hook :initform nil)
   (dims :initform nil :reader scene-dims)))
  
(defclass scene2d (scene)
  ((dims :initform 2)))

(defun make-scene (name dt)
  (make-instance 'scene :name name))

(defmethod add-object ((scene scene) (object object))
  (push object (scene-models scene)))

(defmethod stop-thread ((scene scene))
  (setf (continue-thread scene) nil))
  
(defmethod start-thread ((scene scene))
  (setf (continue-thread scene) T)
  (setf (scene-thread scene) (bt:make-thread
			      (lambda ()
				(loop while (continue-thread scene) do
				     (sleep 2)
				     (format t "after ~a~%" (continue-thread scene)))))))
				
