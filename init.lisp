;; -*-lisp-*-
;; .stumpwmrc
;;
;; Author: Yen-Chin, Lee <coldnew.tw@gmail.com>
;; License: GPL

(in-package :stumpwm)

;;;; Load swank.
;;(load "/usr/share/emacs/site-lisp/slime/swank-loader.lisp")
(load "/home/coldnew/.emacs.d/.cask/25.0.50.1/elpa/slime-20160113.630/swank-loader.lisp")
(swank-loader:init)
;;(ql:quickload :swank)
(let ((server-running nil))
  (defcommand swank () ()
    "Only start swank server once."
    (when (not server-running)
      (swank:create-server :port 4005
                           :style swank:*communication-style*
                           :dont-close t)
      (echo-string (current-screen)
                   "Starting swank. M-x slime-connect RET RET, then (in-package stumpwm).")
      (setf server-running t)))
  ;; start swank
  (swank))

;;; Define window placement policy...

;; plugins
(load "/home/coldnew/.stumpwm.d/modules/dmenu/dmenu-wrapper.lisp")
;;(load "modules/dmenu/dmenu-wrapper.lisp")

;; Clear rules
;; (clear-window-placement-rules)

(defcommand firefox () ()
  (run-or-raise "firefox" '(:class "Firefox")))

(defcommand emacs () ()
  (run-or-raise "emacs" '(:class "Emacs")))

(defcommand konsole () ()
  (run-or-raise "konsole" '(:class "Konsole")))

(defun shift-windows-forward (frames win)
  (when frames
    (let ((frame (car frames)))
      (shift-windows-forward (cdr frames)
                             (frame-window frame))
      (when win
        (pull-window win frame)))))

(defcommand rotate-windows () ()
  (let* ((frames (group-frames (current-group)))
         (win (frame-window (car (last frames)))))
    (shift-windows-forward frames win)))

(defun my-start-hook ()
  (emacs)
  ;;(firefox)
  )


(add-hook *start-hook* #'my-start-hook)

(define-key *root-map* (kbd "f") "firefox")
(define-key *root-map* (kbd "c") "konsole")

(define-key *top-map* (kbd "s-o") "other-window")
(define-key *root-map* (kbd "1") "only")
(define-key *root-map* (kbd "2") "vsplit")
(define-key *root-map* (kbd "3") "hsplit")
;;(define-key *root-map* (kbd "1") "maximize")

;;;; Super pferix
(define-key *top-map* (kbd "s-Left") "move-window left")
(define-key *top-map* (kbd "s-Right") "move-window right")
(define-key *top-map* (kbd "s-Up") "move-window up")
(define-key *top-map* (kbd "s-Down") "move-window down")

(define-key *top-map* (kbd "s-1") "dmenu-run")

;; The mouse focus policy decides how the mouse affects input focus
(setf *mouse-focus-policy* :click)

;;;;;; TODO:
;;(setf *input-window-gravity* :center)
(setf *message-window-gravity* :center)
(setf *message-window-padding* 4)

;;(set-border-color "red")
;; in seconds, how long a mesage will appear for. This must be an integer
;;(setf *timeout-wait* 3)

;;(toggle-mode-line (current-screen) (current-head))