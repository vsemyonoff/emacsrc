;;; use-theme.el ---  theme settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(defvar vs-emacs-theme-enabled-hook nil
  "Normal hook run after new theme was enabled.")

(defun vs|theme/reset (&rest _)
  "Disable already enabled themes before enabling new THEME."
  (mapc
   #'disable-theme
   custom-enabled-themes
   )
  )
(advice-add 'load-theme :before #'vs|theme/reset)

(defun vs|theme/enabled (&rest _)
  "Run `vs-emacs-theme-enabled-hook' hook."
  (run-hooks 'vs-emacs-theme-enabled-hook)
  )
(advice-add 'enable-theme :after #'vs|theme/enabled)

(defun vs|theme/tweaks ()
  "Theme customization."
  (set-face-attribute 'default nil :family "Roboto Mono for Powerline" :height 110)
  (set-face-attribute 'fixed-pitch nil :inherit 'default)
  (set-face-attribute 'variable-pitch nil :family "Roboto")
  (set-face-attribute 'ivy-current-match nil :inherit 'hl-line :background nil :foreground nil)
  (set-face-attribute 'ivy-subdir nil :inherit 'font-lock-builtin-face :foreground nil)
  (set-face-attribute 'show-paren-match nil :underline t)
  )
(add-hook 'vs-emacs-theme-enabled-hook #'vs|theme/tweaks)

(defun vs|theme|enable ()
  "Enable color theme."
  (interactive)
  (when vs-emacs-theme
    (let ((theme-installed (not vs-emacs-theme-package   ))
          (theme-loaded    (custom-theme-p vs-emacs-theme))
          )
      ;; Load theme
      (unless theme-loaded
        (unless theme-installed
          (unless (straight-use-package vs-emacs-theme-package)
            (error "===> Can't install '%s'" vs-emacs-theme-package)
            )
          )
        (unless (setq theme-loaded (load-theme vs-emacs-theme t t))
          (warn "===> Can't load theme '%s'" vs-emacs-theme)
          )
        )
      ;; Enable theme
      (when theme-loaded
        (unless (custom-theme-enabled-p vs-emacs-theme)
          (enable-theme vs-emacs-theme)
          )
        )
      )
    )
  )
(add-hook 'vs-emacs-config-gui-hook #'vs|theme|enable)

(provide 'use-theme)
;;; use-theme.el ends here
