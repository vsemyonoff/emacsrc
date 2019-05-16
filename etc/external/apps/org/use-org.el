;;; use-org.el --- Org mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'org))
    (warn "===> Can't install 'org-mode'")

  (defun vs|org/before-save ()
    "Tags need to be left-adjusted when saving."
    (setf org-tags-column 0)
    (org-align-all-tags)
    )

  (defun vs|org/align-tags ()
    "Revert left-adjusted tag position done by before-save hook."
    (let* ((new-org-tags-column (- (- (window-width) (length org-ellipsis) 3)))
           (tags-aligned    (= new-org-tags-column org-tags-column))
           (modified        (buffer-modified-p))
           (undo-list       buffer-undo-list)
           (undo-tree       buffer-undo-tree))
      (unless tags-aligned
        (setf org-tags-column new-org-tags-column)
        (org-align-all-tags)
        (set-buffer-modified-p modified)
        (setf buffer-undo-list undo-list
              buffer-undo-tree undo-tree
              )
        )
      )
    )

  (defun vs|org/setup ()
    (add-hook 'after-save-hook                  #'vs|org/align-tags  nil t)
    (add-hook 'before-save-hook                 #'vs|org/before-save nil t)
    (add-hook 'window-configuration-change-hook #'vs|org/align-tags  nil t)

    (set (make-local-variable 'system-time-locale) "C")
    (set (make-local-variable 'org-tags-column   )  0 )

    (vs|org/align-tags)
    (whitespace-mode -1)
    (visual-line-mode)
    )

  (add-hook 'org-mode-hook #'vs|org/setup)

  (with-eval-after-load 'org
    (setq org-ellipsis              "▼"
          org-hide-emphasis-markers t
          org-src-fontify-natively  t
          )
    )
  )

(provide 'use-org)
;;; use-org.el ends here
