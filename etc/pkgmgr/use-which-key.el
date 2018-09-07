;;; use-which-key.el --- "use-package" extension. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package which-key :delight
  :config
  (setq which-key-popup-type  'minibuffer
        which-key-show-prefix 'top
        which-key-sort-order  'which-key-description-order)

  :hook (vs-emacs-config . which-key-mode))


(provide 'use-which-key)
;;; use-which-key.el ends here
