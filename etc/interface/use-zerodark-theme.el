;;; use-zerodark-theme.el ---  theme settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package zerodark-theme :defer t
  :hook (vs-emacs-config-gui . vs//enable-theme)
  :init
  (progn
    (defun vs//enable-theme ()
      (load-theme 'zerodark t))))

(provide 'use-zerodark-theme)
;;; use-zerodark-theme.el ends here
