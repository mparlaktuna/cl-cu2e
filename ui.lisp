(in-package :cl-cu2e)

(defclass world2d-pane (clime:never-repaint-background-mixin basic-gadget)
  ((%background :initform (make-rgb-color 0.35 0.35 0.46) :reader background-color)
   (x :initform 0.0 :accessor x)
   (y :initform 0.0 :accessor y)   
   (dragging :initform nil :accessor dragging)))

(defun draw-world2d (pane)
  (format t "drawing 3d world"))

(defmethod handle-repaint ((pane world2d-pane) region)
  (with-bounding-rectangle* (x0 y0 x1 y1) (sheet-region pane)
    (draw-line* pane x0 y0 (/ x1 2) (/ y1 2) :ink (background-color pane))))
    
(define-application-frame cl-cu2e-viewer ()
  ()
  (:menu-bar t)
  (:panes
   (world3d (make-pane 'world2d-pane))
   (interactor :interactor
	       :text-style (make-text-style :sans-serif nil nil)))
  (:layouts
   (default
       (vertically ()
	 (9/10 (labelling (:label "2D World")
		world3d))
	 (1/10 interactor)))))

(defun run-cl-cu2e-viewer ()
  (run-frame-top-level (clim:make-application-frame 'cl-cu2e-viewer)))
