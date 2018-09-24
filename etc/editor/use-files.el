;;; use-files.el ---  files settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package bookmark
  :config
  (setq bookmark-default-file (expand-file-name "bookmarks.el" vs-emacs-cache-dir)
        bookmark-save-flag    1))


(use-package files :ensure nil
  :config
  (setq confirm-nonexistent-file-or-buffer t    ; ask for new buffers
        make-backup-files                  nil) ; disable backup files

  ;; Autosave
  (let ((auto-save-dir
         (expand-file-name "auto-save/" vs-emacs-cache-dir)))
    (setq auto-save-default              t
          auto-save-file-name-transforms `((".*" ,auto-save-dir t))
          auto-save-interval             300
          auto-save-list-file-name       (expand-file-name "auto-save.el" vs-emacs-cache-dir)
          auto-save-timeout              30)
    (unless (file-exists-p auto-save-dir)
      (make-directory auto-save-dir t)))

  :hook (focus-out . do-auto-save))


(use-package recentf
  :config
  (setq recentf-auto-cleanup      300
        recentf-exclude           (list "^/sudo:" "^/tmp/" "^/ssh:" "\\.?ido\\.last$" "\\.revive$"
                                        "/TAGS$" "^/var/folders/.+$" (concat "^" vs-emacs-cache-dir))
        recentf-filename-handlers '(file-truename)
        recentf-max-menu-items    0
        recentf-max-saved-items   300
        recentf-save-file         (expand-file-name "recent.el" vs-emacs-cache-dir))

  :hook (vs-emacs-config . recentf-mode))


(use-package savehist
  :config
  (setq savehist-additional-variables '(search-ring regexp-search-ring)
        savehist-autosave-interval 60
        savehist-file (expand-file-name "history.el" vs-emacs-cache-dir))

  :hook (vs-emacs-config . savehist-mode))


(use-package saveplace
  :config (setq save-place-file (expand-file-name "places.el"
                                                  vs-emacs-cache-dir))

  :hook (vs-emacs-config . save-place-mode))


(provide 'use-files)
;;; use-files.el ends here
