;;; use-recentf.el ---  recentf mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package recentf
  :config
  (progn
    (setq recentf-auto-cleanup      300
          recentf-exclude           (list "^/tmp/" "^/ssh:" "\\.?ido\\.last$" "\\.revive$" "/TAGS$"
                                          "^/var/folders/.+$" (concat "^" (file-truename vs-emacs-cache-dir)))
          recentf-filename-handlers '(file-truename)
          recentf-max-menu-items    0
          recentf-max-saved-items   300
          recentf-save-file         (expand-file-name "recent.el" vs-emacs-cache-dir))

    (defun vs|recentf-exclude-p (file)
      "A predicate to decide whether to exclude FILE from recentf."
      (let ((file-dir (file-truename (file-name-directory file))))
        (cl-some (lambda (dir)
                   (string-prefix-p dir file-dir))
                 (mapcar 'file-truename (list vs-emacs-cache-dir package-user-dir)))))
    (add-to-list 'recentf-exclude #'vs|recentf-exclude-p))

  :hook (vs-emacs-config . recentf-mode))

(provide 'use-recentf)
;;; use-recentf.el ends here
