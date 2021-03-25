(in-package :cl-cu2e)

(defclass world2d-pane (clime:never-repaint-background-mixin basic-gadget)
  ((%background :initform (make-rgb-color 0.35 0.35 0.46) :reader background-color)
   (x :initform 0.0 :accessor x)
   (y :initform 0.0 :accessor y)
   (scene :initarg :scene :accessor world-scene)
   (dragging :initform nil :accessor dragging)))

(defun draw-world2d (pane)
  (format t "drawing 3d world"))

(defmethod handle-repaint ((pane world2d-pane) region)
  (with-bounding-rectangle* (x0 y0 x1 y1) (sheet-region pane)
    (let ((scene (world-scene pane)))
      (mapcar (lambda (x) (draw-object pane x)) (scene-models scene))
      )))

(defmethod draw-object ((pane world2d-pane) (object object))
  (let* ((obj-vis (object-visual object))
	 (pos (model-pos obj-vis))
         (shape (model-shape obj-vis)))
    (draw-shape pane pos shape)))

(defmethod draw-shape ((pane world2d-pane) (pos vec2) (shape circle))
  (draw-circle* pane (vx pos) (vy pos) (circle-radius shape) :filled nil :ink (background-color pane)))
    
(define-application-frame cl-cu2e-viewer ()
  ()
  (:menu-bar t)
  (:panes
   (world2d (make-pane 'world2d-pane :scene (make-scene 'sample)))
   (interactor :interactor
	       :text-style (make-text-style :sans-serif nil nil)))
  (:layouts
   (default
       (vertically ()
	 (7/10 (labelling (:label "2D World")
		world2d))
	 (3/10 interactor)))))

(define-cl-cu2e-viewer-command (com-create-circle :name t)
    ((radius 'number))
  (let* ((gadget (find-pane-named *application-frame* 'world2d))
	 (scene (world-scene gadget)))
    (add-object scene (make-object (make-physical-model (vec 50 50) (make-circle radius))
				   (make-visual-model (vec 100 50) (make-circle radius))))
    (handle-repaint gadget (or (pane-viewport-region gadget)
			       (sheet-region gadget)))))

(defun run-cl-cu2e-viewer ()
  (run-frame-top-level (clim:make-application-frame 'cl-cu2e-viewer)))
