;;; use-autorevert.el ---  autorevert mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package autorevert :delight
  :config (setq auto-revert-use-notify nil)
  :hook (vs-emacs-config . global-auto-revert-mode))

(provide 'use-autorevert)
;;; set-autorevert.el ends here
