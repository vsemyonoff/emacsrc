;;; use-treemacs.el ---  treemacs mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package treemacs
  :config
  (progn
    (setq treemacs-collapse-dirs            3
          treemacs-follow-after-init        t
          treemacs-indentation-string       "  "
          treemacs-indentation              1
          treemacs-is-never-other-window    t
          treemacs-persist-file             (expand-file-name "treemacs.el" vs-emacs-cache-dir)
          treemacs-show-hidden-files        nil
          treemacs-silent-refresh           t
          treemacs-space-between-root-nodes nil
          treemacs-width                    40)

    (treemacs-filewatch-mode                t)
    (treemacs-follow-mode                   t)
    (treemacs-git-mode                      'simple)

    (defun vs|treemacs/add-project (&optional path)
      "Add project from `PATH' to `treemacs'."
      (let* ((path (or path vs-user-home-dir))
             (name (file-name-nondirectory
                    (directory-file-name (if (file-remote-p path)
                                             (car (last (split-string path ":")))
                                           path)))))
        (unless (treemacs-current-workspace)
          (treemacs--find-workspace))
        (treemacs-do-add-project-to-workspace path name)))

    (defun vs|treemacs/mode-setup ()
      "Set `treemacs' mode local variables."
      (setq indicate-buffer-boundaries nil
            indicate-empty-lines       nil
            line-spacing               1
            tab-width                  1  ))

    (defun vs|treemacs/icons-setup ()
      (unless (require 'all-the-icons nil t)
        (error "all-the-icons isn't installed"))

      ;; Silence plistp error with all-the-icons
      (advice-add 'treemacs--pulse-png-advice :override 'ignore)

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

  :hook ((treemacs-mode       . vs|treemacs/mode-setup )
         (vs-emacs-config-gui . vs|treemacs/icons-setup)))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :config (defun vs|treemacs|open ()
            "Add project for current file and open `treemacs' buffer."
            (interactive)
            (vs|treemacs/add-project (condition-case _
                                         (expand-file-name (projectile-project-root))
                                       (error (expand-file-name default-directory))))
            (treemacs-select-window))
  :general ("<C-tab>" 'vs|treemacs|open))

(provide 'use-treemacs)
;;; use-treemacs.el ends here
