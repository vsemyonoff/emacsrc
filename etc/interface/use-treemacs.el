;;; use-treemacs.el ---  treemacs mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package treemacs
  :after projectile
  :config
  (setq treemacs-collapse-dirs            3
        treemacs-indentation-string       "  "
        treemacs-indentation              1
        treemacs-is-never-other-window    nil
        treemacs-persist-file             (expand-file-name "treemacs.el" vs-emacs-cache-dir)
        treemacs-show-hidden-files        nil
        treemacs-silent-refresh           t
        treemacs-space-between-root-nodes t
        treemacs-width                    40)

  (add-to-list 'treemacs-pre-file-insert-predicates 'treemacs-is-file-git-ignored?)

  (when running-on-macos
    (setq treemacs-python-executable      "/usr/local/bin/python3"))

  (treemacs-git-mode                     'extended)
  (treemacs-filewatch-mode                t       )
  (treemacs-follow-mode                  -1       )
  (treemacs-fringe-indicator-mode         t       )
  (treemacs-tag-follow-mode              -1       )

  (defun vs|treemacs/add-project (&optional path)
    "Add project from PATH to `treemacs'."
    (let* ((path (or path vs-user-home-dir))
           (name (file-name-nondirectory
                  (directory-file-name (if (file-remote-p path)
                                           (car (last (split-string path ":")))
                                         path)))))
      (unless (treemacs-current-workspace)
        (treemacs--find-workspace))
      (treemacs-do-add-project-to-workspace path name)))

  (defun vs|treemacs|add-current-project ()
    "Add `projectile-project-root' or `default-directory' to `treemacs'."
    (interactive)
    (vs|treemacs/add-project
     (expand-file-name (condition-case nil
                           (projectile-project-root)
                         (error default-directory)))))

  (defun vs|treemacs|open ()
    "Open `treemacs' buffer."
    (interactive)
    (unless (treemacs-current-workspace)
      (treemacs--find-workspace))
    (when (treemacs-workspace->is-empty?)
      (vs|treemacs|add-current-project))
    (treemacs-select-window))

  (defun vs|treemacs/setup ()
    "Set `treemacs' mode local variables."
    (setq indicate-buffer-boundaries nil
          indicate-empty-lines       nil
          line-spacing               1
          mode-line-format           t
          require-final-newline      nil
          tab-width                  1))

  :general
  ("<C-tab>" 'vs|treemacs|open
   "<f12>"   'vs|treemacs|add-current-project
   "C-x 1"   'treemacs-delete-other-windows)

  :hook
  ((projectile-after-switch-project . vs|treemacs|add-current-project)
   (treemacs-mode                   . vs|treemacs/setup              )))


(provide 'use-treemacs)
;;; use-treemacs.el ends here
