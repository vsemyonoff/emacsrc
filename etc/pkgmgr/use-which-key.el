;;; use-which-key.el --- "use-package" extension. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package which-key :delight
  :config (setq which-key-sort-order 'which-key-key-order-alpha
                which-key-side-window-max-width 0.33
                which-key-idle-delay 0.5)
  :hook ((vs-emacs-config . which-key-mode            )
         (vs-emacs-config . which-key-setup-minibuffer)))

(provide 'use-which-key)
;;; use-which-key.el ends here
