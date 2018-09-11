;;; use-dired.el ---  dired mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package dired :ensure nil
  :config
  (progn
    (setq dired-dwim-target         t
          dired-recursive-copies    'always
          dired-recursive-deletes   'top   )

    (put 'dired-find-alternate-file 'disabled nil)))


(use-package dired+ :ensure quelpa
  :config (diredp-toggle-find-file-reuse-dir 1)
  :quelpa (dired+ :fetcher wiki))


(use-package dired-x :ensure nil)


(provide 'use-dired)
;;; use-dired.el ends here
