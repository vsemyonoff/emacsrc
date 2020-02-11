;;; init.el --- Emacs configuration entry point. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(when (< emacs-major-version 27)
  (load-file (expand-file-name "early-init.el" (file-name-directory user-init-file))))

(add-to-list 'load-path (expand-file-name "etc" user-emacs-directory))

(require 'set-functions)

(if (or after-init-time noninteractive)
    (vs:emacs/disable-optimizations)
  (vs:emacs/enable-optimizations)
  (add-hook 'emacs-startup-hook #'vs:emacs/disable-optimizations t))

(eval-and-compile
  (require 'set-pkgmgr)       ; package manager
  (require 'set-builtins)     ; built-in packages
  (unless noninteractive
    (require 'set-external))) ; external packages

(add-hook 'emacs-startup-hook
          (lambda () (run-hooks 'vs-emacs-config-hook)))

(add-hook (if (daemonp)
              (if (< emacs-major-version 27)
                  'after-make-frame-functions
                'server-after-make-frame-hook)
            'window-setup-hook)
          (lambda (&optional frame)
            (when frame (select-frame-set-input-focus frame))
            (run-hooks 'vs-emacs-config-gui-hook)))

(provide 'init)
;;; init.el ends here
