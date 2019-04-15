;;; use-treemacs.el ---  treemacs mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)
(require 'straight)

(straight-use-package 'treemacs)

;; ;; Triggers
(autoload 'treemacs-current-workspace "treemacs" "Get the current workspace.")
(add-hook 'vs-emacs-config-gui-hook #'vs|treemacs|open)

;; Keybindings
(define-key (current-global-map) (kbd "C-<tab>") #'vs|treemacs|open)
(define-key (current-global-map) (kbd "<f12>"  ) #'vs|treemacs|add-current-project)

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
        treemacs-space-between-root-nodes t
        treemacs-width                    40)
  (treemacs-git-mode                     'extended)
  (treemacs-filewatch-mode                t       )
  (treemacs-follow-mode                   t       )
  (treemacs-fringe-indicator-mode         t       )
  (treemacs-tag-follow-mode              -1       ))

(defun vs|treemacs/add-project (&optional path)
  "Add project from PATH or `default-directory' to `treemacs'."
  (let* ((path (expand-file-name (or path default-directory)))
         (name (file-name-nondirectory
                (directory-file-name (if (file-remote-p path)
                                         (car (last (split-string path ":")))
                                       path)))))
    (unless (treemacs-current-workspace)
      (treemacs--find-workspace))
    (treemacs-do-add-project-to-workspace path name)))

(defun vs|treemacs|add-current-project ()
  "Add `projectile-project-root' to `treemacs'."
  (interactive)
  (vs|treemacs/add-project (projectile-project-root)))

(defun vs|treemacs|open ()
  "Open `treemacs' buffer."
  (interactive)
  (unless (treemacs-current-workspace)
    (treemacs--find-workspace))
  (when (treemacs-workspace->is-empty?)
    (vs|treemacs|add-current-project))
  (treemacs-select-window))

;; (defun vs|treemacs/buffer-setup ()
;;   "Set `treemacs' mode local variables."
;;   (setq indicate-buffer-boundaries nil
;;         indicate-empty-lines       nil
;;         line-spacing               1
;;         mode-line-format           t
;;         require-final-newline      nil
;;         tab-width                  1))

;; (add-hook 'treemacs-mode-hook #'vs|treemacs/buffer-setup)

(straight-use-package 'treemacs-icons-dired)
(with-eval-after-load 'dired
  (add-hook 'dired-mode-hook 'treemacs-icons-dired-mode))

(provide 'use-treemacs)
;;; use-treemacs.el ends here
