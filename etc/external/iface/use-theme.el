;;; use-theme.el ---  theme settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)

(defun vs:theme/reset (&rest _)
  "Disable already enabled themes before enabling new THEME."
  (dolist (theme custom-enabled-themes)
    (disable-theme theme)
   )
  )
(advice-add 'load-theme :before #'vs:theme/reset)

(defun vs:theme/enabled (&rest _)
  "Run `vs-emacs-theme-enabled-hook' hook."
  (run-hooks 'vs-emacs-theme-enabled-hook)
  )
(advice-add 'enable-theme :after #'vs:theme/enabled)

(defun vs:theme/set-fonts ()
  "Apply `vs-emacs-variable-font-family' and `vs-emacs-fixed-font-family'."
  (set-face-attribute 'default nil :family vs-emacs-fixed-font-family :height 110)
  (set-face-attribute 'fixed-pitch nil :family vs-emacs-fixed-font-family)
  (set-face-attribute 'variable-pitch nil :family vs-emacs-variable-font-family)
  )
(add-hook 'vs-emacs-theme-enabled-hook #'vs:theme/set-fonts)

(defun vs:theme/tweaks ()
  "Theme customization."
  (set-face-attribute 'ivy-current-match nil :inherit 'hl-line :background nil :foreground nil)
  (set-face-attribute 'ivy-subdir nil :inherit 'font-lock-builtin-face :foreground nil)
  (set-face-attribute 'show-paren-match nil :underline t :background "white")
  (set-face-attribute 'show-paren-mismatch nil :background "red")
  (set-face-attribute 'cursor nil :background "#ff777a")
  )
(add-hook 'vs-emacs-theme-enabled-hook #'vs:theme/tweaks)

(defun vs:theme|enable ()
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
(add-hook 'vs-emacs-config-gui-hook #'vs:theme|enable)

(provide 'use-theme)
;;; use-theme.el ends here
