;;; use-spacemacs-theme.el ---  theme settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package spacemacs-theme :defer t :disabled
  :hook (vs-emacs-config-gui . vs//enable-theme)
  :init
  (progn
    (defun vs//enable-theme ()
      (load-theme 'spacemacs-dark t))))

(provide 'use-spacemacs-theme)
;;; use-spacemacs-theme.el ends here
