;;; use-treemacs.el ---  treemacs mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)
(require 'straight)

(when (straight-use-package 'treemacs)
  ;; Triggers
  (autoload 'treemacs-current-workspace "treemacs" "Get the current workspace.")

  ;; Keybindings
  (define-key (current-global-map) (kbd "C-<tab>") #'vs|treemacs|open)

  ;; Config
  (with-eval-after-load 'treemacs
    (define-key (current-global-map) (kbd "C-x 1"  )  #'treemacs-delete-other-windows)
    (add-to-list 'treemacs-pre-file-insert-predicates #'treemacs-is-file-git-ignored?)
    (setq treemacs-collapse-dirs            3
          treemacs-indentation-string       "  "
          treemacs-indentation              1
          treemacs-is-never-other-window    nil
          treemacs-persist-file             (expand-file-name "treemacs.el" vs-emacs-cache-dir)
          treemacs-show-hidden-files        nil
          treemacs-silent-refresh           t
          treemacs-space-between-root-nodes nil
          treemacs-width                    40)

    ;; (setq treemacs-icon-open-png   (propertize "⊖ " 'face 'treemacs-directory-face)
    ;;       treemacs-icon-closed-png (propertize "⊕ " 'face 'treemacs-directory-face))

    (treemacs-git-mode                     'extended)
    (treemacs-filewatch-mode                t       )
    (treemacs-follow-mode                   t       )
    (treemacs-fringe-indicator-mode         t       )
    (treemacs-tag-follow-mode              -1       )

    (defun vs|treemacs/buffer-setup ()
      "Set `treemacs' buffer local variables."
      (setq indicate-buffer-boundaries nil
            indicate-empty-lines       nil
            line-spacing               1
            mode-line-format           t
            require-final-newline      nil
            tab-width                  1))
    (add-hook 'treemacs-mode-hook #'vs|treemacs/buffer-setup))

  (defun vs|treemacs/add-project (&optional path)
    "Add project from PATH or `default-directory' to `treemacs' buffer.
When PATH is nil then use `projectile-project-root' or `default-directory'."
    (let* ((path (expand-file-name (or path
                                       (or (projectile-project-root)
                                           default-directory))))
           (name (file-name-nondirectory
                  (directory-file-name (if (file-remote-p path)
                                           (car (last (split-string path ":")))
                                         path)))))
      (unless (treemacs-current-workspace)
        (treemacs--find-workspace))
      (unless (treemacs--find-project-for-path path)
        (treemacs-do-add-project-to-workspace path name))))

  (defun vs|treemacs|open ()
    "Open `treemacs' buffer."
    (interactive)
    (vs|treemacs/add-project)
    (treemacs-select-window))

  ;; (with-eval-after-load 'dired
  ;;   (when (straight-use-package 'treemacs-icons-dired)
  ;;     (add-hook 'dired-mode-hook 'treemacs-icons-dired-mode)))

  (with-eval-after-load 'magit
    (when (straight-use-package 'treemacs-magit)
      (require 'treemacs-magit))))

(provide 'use-treemacs)
;;; use-treemacs.el ends here
