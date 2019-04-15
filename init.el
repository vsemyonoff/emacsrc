;;; init.el --- Emacs configuration entry point. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-functions)

(if (or after-init-time noninteractive)
    (vs|emacs/disable-startup-optimizations)
  (vs|emacs/enable-startup-optimizations))

(eval-and-compile
  (require 'set-builtins)      ; built-in packages settings
  (unless noninteractive
    (require 'set-pkgmgr)      ; package manager settings
    (require 'set-external)    ; editor behavior
    (require 'set-utilities))) ; browser/email/messengers settings

(add-hook 'emacs-startup-hook (lambda () (run-hooks 'vs-emacs-config-hook)))
(add-hook 'emacs-startup-hook #'vs|emacs/disable-startup-optimizations t)

(add-hook (if (daemonp) 'server-after-make-frame-hook 'window-setup-hook)
          (lambda () (run-hooks 'vs-emacs-config-gui-hook)))

(provide 'init)
;;; init.el ends here
