;;; use-zerodark-theme.el ---  theme settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package zerodark-theme :defer t
  :hook (vs-emacs-config-gui . vs//enable-theme)
  :init
  (progn
    (defun vs//enable-theme ()
      (load-theme 'zerodark t)

      ;; Set font
      (set-face-attribute 'default nil :font "Source Code Pro-12")

      ;; Tweak some colors
      (vs::face::scale-color '(font-lock-comment-face
                               font-lock-string-face
                               font-lock-doc-face
                               font-lock-keyword-face
                               hl-line region)
                             10)
      (set-face-attribute 'default nil :foreground "#f8f8f2")
      (set-face-attribute 'ivy-current-match nil
                          :foreground (face-attribute 'default :foreground)
                          :background (face-attribute 'hl-line :background))
      (set-face-attribute 'ivy-subdir nil
                          :foreground (face-attribute 'font-lock-builtin-face :foreground)))))

(provide 'use-zerodark-theme)
;;; use-zerodark-theme.el ends here
