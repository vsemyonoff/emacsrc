;;; set-files.el ---  files settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)


(with-eval-after-load 'bookmark
  (setq bookmark-default-file (expand-file-name "bookmarks.el"
                                                vs-emacs-cache-dir)
        bookmark-save-flag    1))


(with-eval-after-load 'files
  (setq confirm-nonexistent-file-or-buffer t    ; ask for new buffers
        make-backup-files                  nil) ; disable backup files

  (let ((auto-save-dir
         (file-name-as-directory (expand-file-name "auto-save"
                                                   vs-emacs-cache-dir))))
    (setq auto-save-default              t
          auto-save-file-name-transforms `((".*" ,auto-save-dir t))
          auto-save-interval             300
          auto-save-list-file-name       (expand-file-name "auto-save.el"
                                                           vs-emacs-cache-dir)
          auto-save-timeout              30)
    (unless (file-exists-p auto-save-dir)
      (make-directory auto-save-dir t)))
  (add-hook 'focus-out-hook #'do-auto-save)

  (defun vs|emacs/find-file-create-parents (filename &optional _)
    "Create parent directory if not exists while visiting FILENAME."
    (unless (file-exists-p filename)
      (let ((dir (file-name-directory filename)))
        (unless (file-exists-p dir)
          (make-directory dir t)))))
  (advice-add 'find-file :before 'vs|emacs/find-file-create-parents))


(add-hook 'vs-emacs-config-hook #'recentf-mode)
(with-eval-after-load 'recentf
  (setq recentf-auto-cleanup      300
        recentf-exclude           (list "^/sudo:" "^/tmp/" "^/ssh:"
                                        "\\.?ido\\.last$" "\\.revive$"
                                        "/TAGS$" "^/var/folders/.+$"
                                        (concat "^" vs-emacs-cache-dir))
        recentf-filename-handlers '(file-truename)
        recentf-max-menu-items    0
        recentf-max-saved-items   300
        recentf-save-file         (expand-file-name "recent.el" vs-emacs-cache-dir)))


(add-hook 'vs-emacs-config-hook #'savehist-mode)
(with-eval-after-load 'savehist
  (setq savehist-additional-variables '(search-ring regexp-search-ring)
        savehist-autosave-interval 60
        savehist-file (expand-file-name "history.el"
                                        vs-emacs-cache-dir)))


(add-hook 'vs-emacs-config-hook #'save-place-mode)
(with-eval-after-load 'saveplace
  (setq save-place-file (expand-file-name "places.el"
                                          vs-emacs-cache-dir)))


(add-hook 'vs-emacs-config-hook #'global-auto-revert-mode)


(add-hook 'vs-emacs-config-hook #'midnight-mode)


(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)

(provide 'set-files)
;;; set-files.el ends here
