;;; use-projectile.el ---  projectile mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package projectile
  :bind-keymap ("C-c p" . projectile-command-map)
  :init
  (let ((projectile-cache-dir
         (expand-file-name "projectile" vs-cache-dir)))
    (setq projectile-cache-file (expand-file-name "cache.el" projectile-cache-dir)
          projectile-enable-caching (not noninteractive)
          projectile-globally-ignored-file-suffixes '(".elc" ".pyc" ".o")
          projectile-globally-ignored-files '(".DS_Store" "Icon" "TAGS")
          projectile-indexing-method 'alien
          projectile-known-projects-file (expand-file-name "projects.el" projectile-cache-dir)
          projectile-require-project-root nil)

    (unless (file-exists-p projectile-cache-dir)
      (make-directory projectile-cache-dir)))


  :config
  (push ".project" projectile-project-root-files-bottom-up)

  (setq projectile-globally-ignored-directories
        (append projectile-globally-ignored-directories
                (list (abbreviate-file-name vs-cache-dir) ".sync"))
        projectile-other-file-alist
        (append projectile-other-file-alist
                '(("css"  . ("scss" "sass" "less" "styl"))
                  ("scss" . ("css"))
                  ("sass" . ("css"))
                  ("less" . ("css"))
                  ("styl" . ("css")))))

  (defun vs|projectile-locate-dominating-file (orig-fn &rest args)
    "Don't traverse the file system if on a remote connection."
    (unless (file-remote-p default-directory)
      (apply orig-fn args)))
  (advice-add #'projectile-locate-dominating-file :around #'vs|projectile-locate-dominating-file)

  (defun vs|projectile-cache-current-file (orig-fun &rest args)
    "Don't cache ignored files."
    (unless (cl-loop for path in (projectile-ignored-directories)
                     if (string-prefix-p buffer-file-name (expand-file-name path))
                     return t)
      (apply orig-fun args)))
  (advice-add #'projectile-cache-current-file :around #'vs|projectile-cache-current-file)


  :delight (projectile-mode " Ⓟ")
  :hook ((dired-before-readin . projectile-track-known-projects-find-file-hook)
         (vs-config           . projectile-mode                              ))
  )

(provide 'use-projectile)
;;; use-projectile.el ends here
