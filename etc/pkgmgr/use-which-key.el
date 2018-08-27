;;; use-which-key.el --- "use-package" extension. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package which-key
  :config (setq which-key-sort-order 'which-key-key-order-alpha
                which-key-side-window-max-width 0.33
                which-key-idle-delay 0.5)
  :delight (which-key-mode  " Ⓦ")
  :hook ((vs-config . which-key-mode            )
         (vs-config . which-key-setup-minibuffer))
  )

(provide 'use-which-key)
;;; use-which-key.el ends here
