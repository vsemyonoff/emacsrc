;;; use-files.el ---  files settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package files :ensure nil
  :config
  (progn
    (setq confirm-nonexistent-file-or-buffer t    ; ask for new buffers
          make-backup-files                  nil) ; disable backup files

    ;; Autosave
    (let ((auto-save-dir
           (expand-file-name
            (convert-standard-filename "autosave/") vs-emacs-cache-dir)))
      (setq auto-save-default              t
            auto-save-file-name-transforms `((".*" ,auto-save-dir t))
            auto-save-interval             300
            auto-save-list-file-name       (expand-file-name "autosave.el" vs-emacs-cache-dir)
            auto-save-timeout              30)
      (unless (file-exists-p auto-save-dir)
        (make-directory auto-save-dir))))

  :hook (focus-out . do-auto-save))

(provide 'use-files)
;;; use-files.el ends here
