;;; use-treemacs.el ---  treemacs mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)
(require 'straight)

(if (not (straight-use-package 'treemacs))
    (warn "===> Can't install 'treemacs'")

  ;; Triggers
  (autoload 'treemacs-current-workspace    "treemacs" "Get current `treemacs' workspace object.")
  (autoload 'treemacs-delete-other-windows "treemacs" "`delete-other-windows' replacement."    t)

  ;; Keybindings
  (define-key (current-global-map) (kbd "C-<tab>") #'vs|treemacs|open             )
  (define-key (current-global-map) (kbd "C-x 1"  ) #'treemacs-delete-other-windows)

  ;; Config
  (with-eval-after-load 'treemacs
    (add-to-list 'treemacs-pre-file-insert-predicates #'treemacs-is-file-git-ignored?)

    (setq treemacs-collapse-dirs            3
          treemacs-indentation-string       "  "
          treemacs-indentation              1
          treemacs-is-never-other-window    nil
          treemacs-persist-file             (expand-file-name "treemacs.el" vs-emacs-cache-dir)
          treemacs-show-hidden-files        nil
          treemacs-silent-refresh           t
          treemacs-space-between-root-nodes nil
          treemacs-width                    40
          )

    ;; (setq treemacs-icon-open-png   (propertize "⊖ " 'face 'treemacs-directory-face)
    ;;       treemacs-icon-closed-png (propertize "⊕ " 'face 'treemacs-directory-face))

    (treemacs-git-mode                     'extended)
    (treemacs-filewatch-mode                t       )
    (treemacs-follow-mode                  -1       )
    (treemacs-fringe-indicator-mode         t       )
    (treemacs-tag-follow-mode              -1       )

    (defun vs|treemacs/buffer-setup ()
      "Set `treemacs' buffer local variables."
      (setq indicate-buffer-boundaries nil
            indicate-empty-lines       nil
            line-spacing               1
            ;;mode-line-format           t
            require-final-newline      nil
            tab-width                  1)
      )

    (defun vs|treemacs/resize-icons ()
      "Make `treemacs' icons smaller."
      (treemacs-resize-icons 18)
      )

    (add-hook 'treemacs-mode-hook   #'vs|treemacs/buffer-setup)
    (add-hook 'treemacs-select-hook #'vs|treemacs/resize-icons)

    (defun vs|treemacs|collapse-or-go-up ()
      "`treemacs' collapse selected or go to parent node."
      (interactive)
      (treemacs-do-for-button-state
       :on-root-node-open   (treemacs--collapse-root-node btn)
       :on-root-node-closed (ignore)
       :on-dir-node-open    (treemacs--collapse-dir-node btn)
       :on-dir-node-closed  (treemacs-goto-parent-node)
       :on-file-node-open   (treemacs--collapse-file-node btn)
       :on-file-node-closed (treemacs-goto-parent-node)
       :on-tag-node-open    (treemacs--collapse-tag-node btn)
       :on-tag-node-closed  (treemacs-goto-parent-node)
       :on-tag-node-leaf    (ignore)
       :on-nil              (treemacs-pulse-on-failure "There is nothing to do here."))
      )

    (defun vs|treemacs|expand-maybe ()
      "`treemacs' expand selected node."
      (interactive)
      (treemacs-do-for-button-state
       :on-root-node-open   (ignore)
       :on-root-node-closed (treemacs--expand-root-node btn)
       :on-dir-node-open    (ignore)
       :on-dir-node-closed  (treemacs--expand-dir-node btn :recursive nil)
       :on-file-node-open   (ignore)
       :on-file-node-closed (treemacs--expand-file-node btn)
       :on-tag-node-open    (ignore)
       :on-tag-node-closed  (treemacs--expand-tag-node btn)
       :on-tag-node-leaf    (ignore)
       :on-nil              (treemacs-pulse-on-failure "There is nothing to do here."))
      )

    (define-key treemacs-mode-map (kbd "<left>" ) #'vs|treemacs|collapse-or-go-up )
    (define-key treemacs-mode-map (kbd "<right>") #'vs|treemacs|expand-maybe      )
    )

  (defun vs|treemacs/add-project (&optional path)
    "Add project from PATH or `default-directory' to `treemacs' buffer.
When PATH is nil then use `projectile-project-root' or `default-directory'."
    (let* ((path (expand-file-name (or (projectile-project-root
                                        (cond (path
                                               (if (not (directory-name-p path))
                                                   (file-name-directory path)
                                                 path))
                                              (buffer-file-name
                                               (file-name-directory buffer-file-name))))
                                       default-directory)))
           (name (file-name-nondirectory
                  (directory-file-name (if (file-remote-p path)
                                           (car (last (split-string path ":")))
                                         path)))))
      (unless (treemacs-current-workspace)
        (treemacs--find-workspace)
        )
      (unless (treemacs--find-project-for-path path)
        (treemacs-do-add-project-to-workspace path name)
        )
      )
    )

  (defun vs|treemacs|open ()
    "Open `treemacs' buffer."
    (interactive)
    (vs|treemacs/add-project)
    (when buffer-file-name
      (treemacs-find-file))
    (treemacs-select-window)
    )

  (with-eval-after-load 'dired
    (if (not (straight-use-package 'treemacs-icons-dired))
        (warn "===> Can't install 'treemacs-icons-dired'")
      (add-hook 'dired-mode-hook 'treemacs-icons-dired-mode)
      )
    )

  (with-eval-after-load 'magit
    (if (not (straight-use-package 'treemacs-magit))
        (warn "===> Can't install 'treemacs-magit'")
      (require 'treemacs-magit)
      )
    )
  )

(provide 'use-treemacs)
;;; use-treemacs.el ends here
