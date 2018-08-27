;;; use-treemacs.el ---  treemacs mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package treemacs
  :config
  (setq treemacs-collapse-dirs            3
        treemacs-follow-after-init        t
        treemacs-persist-file             (expand-file-name "treemacs.el" vs-cache-dir)
        treemacs-show-hidden-files        nil
        treemacs-silent-refresh           t
        treemacs-space-between-root-nodes nil
        treemacs-width                    40)

  (treemacs-filewatch-mode                t)
  (treemacs-follow-mode                   t)
  (treemacs-git-mode                      'extended)

  (defun vs//treemacs-add-project (&optional path)
    "Add project from `PATH' to `treemacs'."
    (let ((path (or path user-home-dir)))
      (unless (treemacs-current-workspace)
        (treemacs--find-workspace))
      (let ((name (file-name-nondirectory (directory-file-name path))))
        (treemacs-do-add-project-to-workspace path name))))
  )

(use-package treemacs-projectile
  :after projectile
  :bind (:map global-map ([C-tab] . vs/treemacs-open))
  :config (defun vs/treemacs-open ()
            "Setup project for current file and open `treemacs' buffer."
            (interactive)
            (vs//treemacs-add-project (condition-case _
                                          (expand-file-name (projectile-project-root))
                                        (error (expand-file-name default-directory))))
            (treemacs-select-window))
  )

(provide 'use-treemacs)
;;; use-treemacs.el ends here
