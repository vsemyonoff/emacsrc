;;; use-saveplace.el ---  saveplace mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package saveplace
  :config (setq save-place-file (expand-file-name "places.el"
                                                  vs-emacs-cache-dir))

  :hook (vs-emacs-config . save-place-mode))


(provide 'use-saveplace)
;;; use-saveplace.el ends here
