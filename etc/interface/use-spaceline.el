;;; use-spaceline.el ---  mode line settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package spaceline
  :hook (vs-emacs-config . spaceline-emacs-theme))

;; (use-package spaceline-all-the-icons
;;   :after spaceline
;;   :config (defun vs|enable-spaceline-all-the-fonts ()
;;             (if (window-system (selected-frame))
;;                 (spaceline-all-the-icons-theme)
;;               (spaceline-emacs-theme)))
;;   :hook (vs-emacs-config-gui . vs|enable-spaceline-all-the-fonts))

(provide 'use-spaceline)
;;; use-spaceline.el ends here
