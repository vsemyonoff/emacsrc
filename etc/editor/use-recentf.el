;;; use-recentf.el ---  recentf mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package recentf
  :config
  (setq recentf-auto-cleanup      300
        recentf-exclude           (list "^/tmp/" "^/ssh:" "\\.?ido\\.last$" "\\.revive$" "/TAGS$"
                                        "^/var/folders/.+$" (concat "^" (file-truename vs-cache-dir)))
        recentf-filename-handlers '(file-truename)
        recentf-max-menu-items    0
        recentf-max-saved-items   300
        recentf-save-file         (expand-file-name "recent.el" vs-cache-dir))

  (defun vs|recentf-exclude-p (file)
    "A predicate to decide whether to exclude FILE from recentf."
    (let ((file-dir (file-truename (file-name-directory file))))
      (cl-some (lambda (dir)
                 (string-prefix-p dir file-dir))
               (mapcar 'file-truename (list vs-cache-dir package-user-dir)))))

  (add-to-list 'recentf-exclude #'vs|recentf-exclude-p)


  :hook (vs-config . recentf-mode)
  )

(provide 'use-recentf)
;;; use-recentf.el ends here
