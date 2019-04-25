;;; set-files.el ---  files settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; Bookmarks
(with-eval-after-load 'bookmark
  (setq bookmark-default-file (vs|emacs/cache "bookmarks.el")
        bookmark-save-flag    1
        )
  )

;; Auto-save/backup
(with-eval-after-load 'files
  (setq confirm-nonexistent-file-or-buffer t   ; ask for new buffers
        find-file-visit-truename           t   ; follow symlinks while opening files
        make-backup-files                  nil ; disable backup files
        )

  (let ((auto-save-dir (file-name-as-directory (vs|emacs/cache "auto-save"))))
    (setq auto-save-default              t
          auto-save-file-name-transforms `((".*" ,auto-save-dir t))
          auto-save-interval             300
          auto-save-list-file-name       (vs|emacs/cache "auto-save.el")
          auto-save-timeout              30
          )
    (unless (file-exists-p auto-save-dir)
      (make-directory auto-save-dir t)
      )
    )
  (add-hook 'focus-out-hook #'do-auto-save)

  (defun vs|emacs/find-file-create-parents (filename &optional _)
    "Create parent directory if not exists while visiting FILENAME."
    (unless (file-exists-p filename)
      (let ((dir (file-name-directory filename)))
        (unless (file-exists-p dir)
          (make-directory dir t)
          )
        )
      )
    )
  (advice-add 'find-file :before 'vs|emacs/find-file-create-parents)
  )

;; Recently visited files list
(add-hook 'vs-emacs-config-hook #'recentf-mode)
(with-eval-after-load 'recentf
  (setq recentf-auto-cleanup      300
        recentf-exclude           (list "^/sudo:" "^/tmp/" "^/ssh:"
                                        "\\.?ido\\.last$" "\\.revive$"
                                        "/TAGS$" "^/var/folders/.+$"
                                        (concat "^" vs-emacs-cache-dir)
                                        )
        recentf-filename-handlers '(file-truename)
        recentf-max-menu-items    0
        recentf-max-saved-items   300
        recentf-save-file         (vs|emacs/cache "recent.el")
        )
  )

;; Svae history
(add-hook 'vs-emacs-config-hook #'savehist-mode)
(with-eval-after-load 'savehist
  (setq savehist-additional-variables '(search-ring regexp-search-ring)
        savehist-autosave-interval    60
        savehist-file (vs|emacs/cache "history.el")
        )
  )

;; Save last visited place in files
(add-hook 'vs-emacs-config-hook #'save-place-mode)
(with-eval-after-load 'saveplace
  (setq save-place-file (vs|emacs/cache "places.el"))
  )

;; Revert files if changed outside
(add-hook 'vs-emacs-config-hook #'global-auto-revert-mode)

;; Cleanup unused buffers
(add-hook 'vs-emacs-config-hook #'midnight-mode)

;; Make shell scripts executable afte save
(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)

(provide 'set-files)
;;; set-files.el ends here
