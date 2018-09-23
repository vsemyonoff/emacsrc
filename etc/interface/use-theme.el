;;; use-theme.el ---  theme settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package zerodark-theme :defer t
  :hook ((vs-emacs-config     . zerodark-setup-modeline-format)
         (vs-emacs-config-gui . vs|theme/enable               ))
  :init
  (defun vs|theme/enable ()
    ;; Load theme
    (load-theme 'zerodark t t)
    (enable-theme 'zerodark)

    ;; Set font
    (set-face-attribute 'default nil :font "Source Code Pro-12" :foreground "#f8f8f2")

    ;; Increase faces background
    (let ((faces '(error hl-line region success warning)))
      (vs|emacs/scale-face-color faces 10 t))

    ;; Increase face foreground
    (let ((faces '(font-lock-builtin-face font-lock-comment-face
                   font-lock-constant-face font-lock-doc-face
                   font-lock-function-name-face font-lock-keyword-face
                   font-lock-string-face font-lock-type-face
                   font-lock-variable-name-face)))
      (vs|emacs/scale-face-color faces 20))

    ;; Change colors
    (set-face-attribute 'company-preview-common nil :inherit 'font-lock-string-face :foreground nil)
    (set-face-attribute 'company-tooltip-common nil :inherit 'font-lock-string-face :foreground nil)
    (set-face-attribute 'company-tooltip-common-selection nil :inherit 'font-lock-string-face :foreground nil)
    (set-face-attribute 'ivy-current-match nil :inherit 'hl-line :background nil :foreground nil)
    (set-face-attribute 'ivy-subdir nil :inherit 'font-lock-builtin-face :foreground nil)
    (set-face-attribute 'show-paren-match nil :inherit 'error :background nil :foreground nil :underline t)))


(provide 'use-theme)
;;; use-theme.el ends here
