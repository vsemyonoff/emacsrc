;;; use-org.el --- Org mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'org))
    (warn "===> Can't install 'org-mode'")

  (if (not (straight-use-package 'org-bullets))
      (warn "===> Can't install 'org-bullets'")

    (add-hook 'org-mode-hook #'org-bullets-mode)

    (with-eval-after-load 'org-bullets
      (setq org-bullets-bullet-list '("☉" "⚫" "⚬" "•"))
      )
    )

  (defun vs|org/before-save ()
    "Tags need to be left-adjusted when saving."
    (org-align-all-tags)
    )

  (defun vs|org/after-save ()
    "Revert left-adjusted tag position done by before-save hook."
    (let ((org-tags-column (- (- (window-width) (length org-ellipsis) 3))))
      (org-align-all-tags)
      (set-buffer-modified-p nil)
      )
    )

  (defun vs|org/setup ()
    (add-hook 'after-save-hook                  #'vs|org/after-save  nil t)
    (add-hook 'before-save-hook                 #'vs|org/before-save nil t)
    (add-hook 'window-configuration-change-hook #'vs|org/after-save  nil t)
    (progn
      (vs|org/after-save)
      (setq buffer-undo-list nil
            buffer-undo-tree nil
            )
      )
    (whitespace-mode -1)
    (visual-line-mode)
    )

  (add-hook 'org-mode-hook #'vs|org/setup)

  (with-eval-after-load 'org
    (setq org-ellipsis              "▼"
          org-hide-emphasis-markers t
          org-tags-column           0
          )
    )
  )

(provide 'use-org)
;;; use-org.el ends here
