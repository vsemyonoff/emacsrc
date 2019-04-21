;;; use-theme.el ---  theme settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)
(require 'straight)

;; (advice-add 'enable-theme :before (lambda (&optional _)
;;                                     "Disable already enabled themes before enabling the new one."
;;                                     (mapc #'disable-theme custom-enabled-themes)
;;                                     ))

(defun vs|theme|enable ()
  "Enable color theme."
  (interactive)
  (let ((theme-loaded nil))
    (when vs-emacs-theme
      ;; Load theme
      (when (not (setq theme-loaded (custom-theme-p vs-emacs-theme)))
        (when vs-emacs-theme-package
          (if (not (straight-use-package vs-emacs-theme-package))
              (warn "===> Can't install '%s'" vs-emacs-theme-package)
            (setq theme-loaded (load-theme vs-emacs-theme t t))
            )
          )
        )
      ;; Enable theme
      (if (not theme-loaded)
          (warn "===> Can't enable theme '%s'" vs-emacs-theme)
        (mapc 'disable-theme custom-enabled-themes)
        (enable-theme vs-emacs-theme)
        )
      )
    )
  ;; Set default font
  (set-face-attribute 'default (selected-frame) :font "Roboto Mono" :height 100); :foreground "#f8f8f2")
  (set-face-attribute 'ivy-current-match (selected-frame) :inherit 'hl-line :background nil :foreground nil)
  (set-face-attribute 'ivy-subdir (selected-frame) :inherit 'font-lock-builtin-face :foreground nil)
  (set-face-attribute 'show-paren-match (selected-frame) :inherit 'error :background nil :foreground nil :underline t)
  )
(add-hook 'vs-emacs-config-gui-hook #'vs|theme|enable)

(provide 'use-theme)
;;; use-theme.el ends here
