(in-package :cl-cu2e)

(defclass world2d-pane (basic-gadget)
  ((%background :initform (make-rgb-color 0.35 0.35 0.46) :reader background-color)
   (x :initform 0.0 :accessor x)
   (y :initform 0.0 :accessor y)
   (scene :initarg :scene :accessor world-scene)
   (scene-tf :initform (mat3 '(1 0 200 0 1 300 0 0 1)) :accessor scene-tf)
   (dragging :initform nil :accessor dragging)))

(defun draw-world2d (pane)
  (format t "drawing 3d world"))

(defmethod handle-repaint ((pane world2d-pane) region)
  (with-bounding-rectangle* (x0 y0 x1 y1) (sheet-region pane)
    (draw-rectangle* (sheet-medium pane) x0 y0 x1 y1 :ink +white+)
    (let ((scene (world-scene pane)))
      (mapcar (lambda (x) (draw-object pane x)) (scene-models scene))
      )))

(defmethod draw-object ((pane world2d-pane) (object object))
  (let* ((obj-vis (object-visual object))
	 (pos (model-pos obj-vis))
         (shape (model-shape obj-vis))
         (scene-tf (scene-tf pane))
         (pos3d (m* scene-tf (v+ (vec 0 0 1) (vxy_ pos)))))
    (format t "~a" pos3d)
    (draw-shape pane pos shape)))

(defmethod draw-shape ((pane world2d-pane) (pos vec2) (shape circle))
  (draw-circle* pane (vx pos) (vy pos) (circle-radius shape) :filled nil))
    
(define-application-frame cl-cu2e-viewer ()
  ()
  (:menu-bar t)
  (:panes
   (world2d (make-pane 'world2d-pane :width 1600 :height 500 :scene (make-scene 'sample 1)))
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

(define-cl-cu2e-viewer-command (com-start-scene :name t)
    ()
  (let* ((gadget (find-pane-named *application-frame* 'world2d))
	 (scene (world-scene gadget)))
    (start-thread scene)))

(define-cl-cu2e-viewer-command (com-stop-scene :name t)
    ()
  (let* ((gadget (find-pane-named *application-frame* 'world2d))
	 (scene (world-scene gadget)))
    (stop-thread scene)))

(define-cl-cu2e-viewer-command (com-clear-objects :name t)
    ()
  (let* ((gadget (find-pane-named *application-frame* 'world2d))
	 (scene (world-scene gadget)))
    (clear-objects scene)
    (handle-repaint gadget (or (pane-viewport-region gadget)
			       (sheet-region gadget)))))


(defun run-cl-cu2e-viewer ()
  (run-frame-top-level (clim:make-application-frame 'cl-cu2e-viewer)))
