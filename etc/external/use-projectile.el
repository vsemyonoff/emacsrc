;;; use-projectile.el ---  projectile mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package projectile
  :hook (vs-emacs-config . projectile-mode)
  :bind ("M-p" . projectile-command-map)
  :config
  (let ((cache-dir (vs:emacs/cache "projectile")))
    (setq projectile-cache-file                     (expand-file-name "cache.el" cache-dir)
          projectile-completion-system              'ivy
          projectile-enable-caching                 nil ; (not noninteractive)
          projectile-globally-ignored-file-suffixes '(".elc" ".pyc" ".o")
          projectile-globally-ignored-files         '(".DS_Store" "Icon" "TAGS")
          projectile-indexing-method                'alien
          projectile-known-projects-file            (expand-file-name "projects.el" cache-dir)
          projectile-project-search-path            vs-user-projects-dir
          projectile-require-project-root           t
          )
    (unless (file-exists-p cache-dir)
      (make-directory cache-dir t)
      )
    )
  ;; (defun vs:projectile/cache-filter (orig-fun &rest args)
  ;;   "Don't cache ignored files."
  ;;   (unless (cl-loop for path in (projectile-ignored-directories)
  ;;                    if (string-prefix-p buffer-file-name (expand-file-name path))
  ;;                    return t)
  ;;     (apply orig-fun args)
  ;;     )
  ;;   )
  ;; (advice-add 'projectile-cache-current-file :around 'vs:projectile/cache-filter)

  (add-to-list 'projectile-globally-ignored-directories (abbreviate-file-name vs-emacs-cache-dir))
  ;; (add-to-list 'projectile-project-root-files-bottom-up "compile_commands.json")
  ;; (add-to-list 'projectile-project-root-files-bottom-up "CMakeLists.txt")
  ;; (add-to-list 'projectile-project-root-files-bottom-up "SConstruct")
  )

(provide 'use-projectile)
;;; use-projectile.el ends here
