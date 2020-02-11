;;; early-init.el --- Emacs configuration entry point (since Emacs v27). -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))

;; Don't call `package-initialize' after init, will do that manually.
(setq package-enable-at-startup nil)

(provide 'early-init)
;;; early-init.el ends here
