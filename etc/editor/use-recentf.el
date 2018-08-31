;;; use-recentf.el ---  recentf mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package recentf
  :config
  (progn
    (setq recentf-auto-cleanup      300
          recentf-exclude           (list "^/sudo:" "^/tmp/" "^/ssh:" "\\.?ido\\.last$" "\\.revive$"
                                          "/TAGS$" "^/var/folders/.+$" (concat "^" vs-emacs-cache-dir))
          recentf-filename-handlers '(file-truename)
          recentf-max-menu-items    0
          recentf-max-saved-items   300
          recentf-save-file         (expand-file-name "recent.el" vs-emacs-cache-dir)))

  :hook (vs-emacs-config . recentf-mode))

(provide 'use-recentf)
;;; use-recentf.el ends here
