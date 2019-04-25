;;; use-projectile.el ---  projectile mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'projectile))
    (warn "===> Can't install 'projectile'")

  ;; Triggers
  (add-hook 'vs-emacs-config-hook #'projectile-mode)

  ;; Keybindings
  (define-key (current-global-map) (kbd "M-p") 'projectile-command-map)

  ;; Config
  (with-eval-after-load 'projectile
    (let ((projectile-cache-dir (vs|emacs/cache "projectile")))
      (setq projectile-cache-file                     (expand-file-name "cache.el" projectile-cache-dir)
            projectile-completion-system              'ivy
            projectile-enable-caching                 (not noninteractive)
            projectile-globally-ignored-file-suffixes '(".elc" ".pyc" ".o")
            projectile-globally-ignored-files         '(".DS_Store" "Icon" "TAGS")
            projectile-indexing-method                'alien
            projectile-known-projects-file            (expand-file-name "projects.el" projectile-cache-dir)
            projectile-mode-line                      nil
            projectile-project-search-path            vs-user-projects
            projectile-require-project-root           t
            )

      (unless (file-exists-p projectile-cache-dir)
        (make-directory projectile-cache-dir t)
        )
      )

    (add-to-list 'projectile-globally-ignored-directories (abbreviate-file-name vs-emacs-cache-dir))
    (add-to-list 'projectile-project-root-files-bottom-up "compile_commands.json")
    (add-to-list 'projectile-project-root-files-bottom-up "CMakeLists.txt")
    (add-to-list 'projectile-project-root-files-bottom-up "SConstruct")

    (defun vs|projectile/cache-filter (orig-fun &rest args)
      "Don't cache ignored files."
      (unless (cl-loop for path in (projectile-ignored-directories)
                       if (string-prefix-p buffer-file-name (expand-file-name path))
                       return t)
        (apply orig-fun args)
        )
      )
    (advice-add 'projectile-cache-current-file :around 'vs|projectile/cache-filter)
    )
  )

(provide 'use-projectile)
;;; use-projectile.el ends here
