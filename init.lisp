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

;; Clear rules
;; (clear-window-placement-rules)

(defcommand firefox () ()
            (run-or-raise "firefox" '(:class "Firefox")))

(defcommand emacs () ()
            (run-or-raise "emacs" '(:class "Emacs")))

(defun my-start-hook ()
  (emacs)
  ;;(firefox)
  )


(add-hook *start-hook* #'my-start-hook)

(define-key *root-map* (kbd "f") "firefox")