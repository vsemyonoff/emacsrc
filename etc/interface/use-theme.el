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
    (set-face-attribute 'default nil :font "Source Code Pro-12")

    ;; Increase some faces color saturation
    (vs|emacs/scale-face-color '( ;; Font lock faces
                                 font-lock-builtin-face
                                 font-lock-comment-face
                                 font-lock-constant-face
                                 font-lock-doc-face
                                 font-lock-function-name-face
                                 font-lock-keyword-face
                                 font-lock-string-face
                                 font-lock-type-face
                                 font-lock-variable-name-face
                                 ;; Other
                                 error
                                 hl-line
                                 region
                                 show-paren-match
                                 success
                                 warning)
                               10)

    ;; Change colors
    (set-face-attribute 'default nil
                        :foreground "#f8f8f2")
    (set-face-attribute 'show-paren-match nil
                        :underline t)
    (set-face-attribute 'ivy-current-match nil
                        :background (face-attribute 'hl-line
                                                    :background)
                        :foreground (face-attribute 'default
                                                    :foreground))
    (set-face-attribute 'ivy-subdir nil
                        :foreground (face-attribute 'font-lock-builtin-face
                                                    :foreground))
    (set-face-attribute 'company-preview-common nil
                        :foreground (face-attribute 'font-lock-string-face
                                                    :foreground))
    (set-face-attribute 'company-tooltip-common nil
                        :foreground (face-attribute 'font-lock-string-face
                                                    :foreground))
    (set-face-attribute 'company-tooltip-common-selection nil
                        :foreground (face-attribute 'font-lock-string-face
                                                    :foreground))))


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
