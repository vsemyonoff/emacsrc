;;; use-projectile.el ---  projectile mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package projectile :delight
  :config
  (progn
    (let ((projectile-cache-dir                       (expand-file-name "projectile" vs-emacs-cache-dir)))
      (setq projectile-cache-file                     (expand-file-name "cache.el" projectile-cache-dir)
            projectile-completion-system              'ivy
            projectile-enable-caching                 (not noninteractive)
            projectile-globally-ignored-file-suffixes '(".elc" ".pyc" ".o")
            projectile-globally-ignored-files         '(".DS_Store" "Icon" "TAGS")
            projectile-indexing-method                'alien
            projectile-known-projects-file            (expand-file-name "projects.el" projectile-cache-dir)
            projectile-mode-line                      nil
            projectile-globally-ignored-directories   (append projectile-globally-ignored-directories
                                                              (list (abbreviate-file-name vs-emacs-cache-dir) ".sync"))
            projectile-other-file-alist               (append projectile-other-file-alist
                                                              '(("css"  . ("scss" "sass" "less" "styl"))
                                                                ("scss" . ("css"))
                                                                ("sass" . ("css"))
                                                                ("less" . ("css"))
                                                                ("styl" . ("css")))))

      (unless (file-exists-p projectile-cache-dir)
        (make-directory projectile-cache-dir t)))

    (push ".project" projectile-project-root-files-bottom-up)

    (defun vs|projectile/cache-filter (orig-fun &rest args)
      "Don't cache ignored files."
      (unless (cl-loop for path in (projectile-ignored-directories)
                       if (string-prefix-p buffer-file-name (expand-file-name path))
                       return t)
        (apply orig-fun args)))
    (advice-add 'projectile-cache-current-file :around 'vs|projectile/cache-filter))

  :general ("M-p" '(projectile-command-map :which-key "Projectile"))

  :hook (vs-emacs-config . projectile-global-mode))


(provide 'use-projectile)
;;; use-projectile.el ends here
