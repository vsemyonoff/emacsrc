;;; use-all-the-icons.el ---  pretty icons package. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)

(if (not (straight-use-package 'all-the-icons))
    (warn "===> Can't install 'all-the-icons'")

  ;; Triggers
  (autoload 'all-the-icons-alltheicon "all-the-icons")
  (autoload 'all-the-icons-faicon "all-the-icons")
  (autoload 'all-the-icons-fileicon "all-the-icons")
  (autoload 'all-the-icons-install-fonts "all-the-icons")
  (autoload 'all-the-icons-material "all-the-icons")
  (autoload 'all-the-icons-octicon "all-the-icons")
  (autoload 'all-the-icons-wicon "all-the-icons")

  ;; (with-eval-after-load 'dired
  ;;   (if (not (straight-use-package 'all-the-icons-dired))
  ;;       (warn "===> Can't install 'all-the-icons-dired'")
  ;;     (add-hook 'dired-mode-hook #'all-the-icons-dired-mode)
  ;;     )
  ;;   )
  )

(provide 'use-all-the-icons)
;;; use-all-the-icons.el ends here
