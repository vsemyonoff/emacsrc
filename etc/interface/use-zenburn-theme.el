;;; use-zenburn-theme.el ---  theme settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package zenburn-theme :defer t
  :hook (vs-emacs-config-gui . vs//enable-theme)
  :init
  (progn
    (defun vs//enable-theme ()
      ;; (setq zenburn-override-colors-alist
      ;;       '(("zenburn-bg+05" . "#282828")
      ;;         ("zenburn-bg+1"  . "#2F2F2F")
      ;;         ("zenburn-bg+2"  . "#3F3F3F")
      ;;         ("zenburn-bg+3"  . "#4F4F4F")))
      (load-theme 'zenburn t))))

(provide 'use-zenburn-theme)
;;; use-zenburn-theme.el ends here
