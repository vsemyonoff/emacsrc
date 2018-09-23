;;; use-theme.el ---  theme settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package zerodark-theme :defer t
  :hook (vs-emacs-config-gui . vs|theme/enable)
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


(use-package telephone-line
  :config
  (setq vs-mode-separator (make-instance 'telephone-line-unicode-separator :char #xe905))
  (setq telephone-line-primary-left-separator    'vs-mode-separator
        telephone-line-secondary-left-separator  'vs-mode-separator
        telephone-line-primary-right-separator   'vs-mode-separator
        telephone-line-secondary-right-separator 'vs-mode-separator

        telephone-line-height 18

        telephone-line-lhs '((nil . (telephone-line-buffer-segment
                                     telephone-line-simple-major-mode-segment
                                     telephone-line-vc-segment
                                     telephone-line-process-segment
                                     telephone-line-flycheck-segment)))

        telephone-line-rhs '((nil . (;;telephone-line-misc-info-segment
                                     telephone-line-airline-position-segment))))

  :hook (vs-emacs-config . telephone-line-mode))


(provide 'use-theme)
;;; use-theme.el ends here
