;;; use-treemacs.el ---  treemacs mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package treemacs
  :config
  (progn
    (setq treemacs-collapse-dirs            3
          treemacs-indentation-string       "  "
          treemacs-indentation              1
          treemacs-is-never-other-window    nil
          treemacs-persist-file             (expand-file-name "treemacs.el" vs-emacs-cache-dir)
          treemacs-show-hidden-files        nil
          treemacs-silent-refresh           t
          treemacs-space-between-root-nodes nil
          treemacs-width                    40)

    (defun vs|treemacs/add-project (&optional path)
      "Add project from PATH to `treemacs'."
      (let* ((path (or path vs-user-home-dir))
             (name (file-name-nondirectory
                    (directory-file-name (if (file-remote-p path)
                                             (car (last (split-string path ":")))
                                           path)))))
        (unless (treemacs-current-workspace)
          (treemacs--find-workspace))
        (treemacs-do-add-project-to-workspace path name)))

    (defun vs|treemacs/setup ()
      "Set `treemacs' mode local variables."
      (setq indicate-buffer-boundaries nil
            indicate-empty-lines       nil
            line-spacing               1
            mode-line-format           t
            tab-width                  1       )
      (treemacs-git-mode              'extended)
      (treemacs-filewatch-mode         t       )
      (treemacs-follow-mode           -1       )
      (treemacs-fringe-indicator-mode -1       )
      (treemacs-tag-follow-mode       -1       ))

    (defun vs|treemacs/setup-icons ()
      "Setup `treemacs' file icons."

      (unless (require 'all-the-icons nil t)
        (error "Error: all-the-icons is not installed"))

      (set-face-attribute 'treemacs-directory-collapsed-face nil :bold    t        :italic       t)
      (set-face-attribute 'treemacs-directory-face           nil :bold    t                       )

      (let ((all-the-icons-default-adjust 0))
        ;; Folders
        (setq treemacs-icon-closed-png          (concat (all-the-icons-octicon "file-directory"
                                                                               :v-adjust 0 :height 1.15
                                                                               :face 'font-lock-doc-face)
                                                        " ")
              treemacs-icon-open-png            (concat (all-the-icons-octicon "file-directory" :v-adjust 0 :height 1.15)
                                                        " ")
              treemacs-icon-root-png            (concat " " (all-the-icons-octicon "repo"
                                                                                   :v-adjust -0.1 :height 1.6
                                                                                   :face 'font-lock-string-face)
                                                        " ")
              treemacs-icon-tag-closed-png      (concat (all-the-icons-octicon "chevron-right"
                                                                               :v-adjust 0.1)
                                                        " ")
              treemacs-icon-tag-node-closed-png (concat (all-the-icons-octicon "chevron-right"
                                                                               :height 0.9
                                                                               :face 'font-lock-keyword-face)
                                                        " ")
              treemacs-icon-tag-node-open-png   (concat (all-the-icons-octicon "chevron-down"
                                                                               :height 0.75
                                                                               :face 'font-lock-keyword-face)
                                                        " ")
              treemacs-icon-tag-open-png        (concat (all-the-icons-octicon "chevron-down" :v-adjust 0.1)
                                                        " ")
              treemacs-icon-tag-leaf-png        "- ")
        ;; Files
        (setq treemacs-icons-hash    (make-hash-table :size 200 :test #'equal)
              treemacs-icon-fallback (concat (all-the-icons-octicon "file-code" :height 1.2)
                                             " ")
              treemacs-icon-text     treemacs-icon-fallback)
        ;; File types
        (treemacs-define-custom-icon (all-the-icons-octicon "file-media" :height 1.2)
                                     "png" "jpg" "jpeg" "gif"  "ico" "tif" "tiff" "svg"  "bmp"
                                     "psd" "ai"  "eps"  "indd" "mov" "avi" "mp4"  "webm" "mkv"
                                     "wav" "mp3" "ogg"  "midi")
        (treemacs-define-custom-icon (all-the-icons-octicon "file-text" :height 1.2)
                                     "md" "markdown" "rst" "log" "org" "txt"
                                     "CONTRIBUTE" "LICENSE" "README" "CHANGELOG")
        (treemacs-define-custom-icon (all-the-icons-octicon "file-code" :height 1.2)
                                     "json" "xml" "ini" "tpl" "mk"))))

  :general ("C-x 1" 'treemacs-delete-other-windows)

  :hook
  ((treemacs-mode       . vs|treemacs/setup      )
   (vs-emacs-config-gui . vs|treemacs/setup-icons)))


(use-package treemacs-projectile
  :after (treemacs projectile)
  :config
  (defun vs|treemacs-projectile|add-current-project ()
    "Add `projectile-project-root' or `default-directory' to `treemacs'."
    (interactive)
    (vs|treemacs/add-project (expand-file-name (condition-case nil
                                                   (projectile-project-root)
                                                 (error default-directory)))))

  (defun vs|treemacs-projectile|open ()
    "Add default project (if needed) and open `treemacs' window."
    (interactive)
    (unless (treemacs-current-workspace)
      (treemacs--find-workspace))
    (when (treemacs-workspace->is-empty?)
      (vs|treemacs-projectile|add-current-project))
    (treemacs-select-window))

  :general ("<C-tab>" 'vs|treemacs-projectile|open
            "<f12>"   'vs|treemacs-projectile|add-current-project)

  :hook (projectile-after-switch-project . vs|treemacs-projectile|add-current-project))


(provide 'use-treemacs)
;;; use-treemacs.el ends here
