;;; use-theme.el ---  theme settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

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
            (unless (setq theme-loaded (load-theme vs-emacs-theme t t))
              (warn "===> Can't load theme '%s'" vs-emacs-theme)
              )
            )
          )
        )
      ;; Enable theme
      (when theme-loaded
        (unless (custom-theme-enabled-p vs-emacs-theme)
          ;; Apply theme
          (mapc 'disable-theme custom-enabled-themes)
          (enable-theme vs-emacs-theme)
          )
        )
      )
    )
  (set-face-attribute 'default nil :family "Roboto Mono" :height 110)
  (set-face-attribute 'fixed-pitch nil :family "Roboto Mono")
  (set-face-attribute 'variable-pitch nil :family "Roboto")
  ;; (set-face-attribute 'ivy-current-match nil :inherit 'hl-line :background nil :foreground nil)
  ;; (set-face-attribute 'ivy-subdir nil :inherit 'font-lock-builtin-face :foreground nil)
  (set-face-attribute 'show-paren-match nil :inherit 'error :background nil :foreground nil :underline t)
  )

(add-hook 'vs-emacs-config-hook #'vs|theme|enable)

(provide 'use-theme)
;;; use-theme.el ends here
