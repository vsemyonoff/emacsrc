;;; use-all-the-icons.el ---  pretty icons package. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package all-the-icons
  :commands (all-the-icons-octicon all-the-icons-faicon all-the-icons-fileicon
             all-the-icons-wicon all-the-icons-material all-the-icons-alltheicon
             all-the-icons-install-fonts))


(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))


(provide 'use-all-the-icons)
;;; use-all-the-icons.el ends here
