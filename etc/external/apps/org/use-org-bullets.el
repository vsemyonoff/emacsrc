;;; use-org-bullets.el --- Pretty org-mode bullets. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package org-bullets
  :after org
  :hook (org-mode .  org-bullets-mode)
  :config
  (setq org-bullets-bullet-list `(,(all-the-icons-faicon "dot-circle-o")
                                  "☉" "⚫" "⚬" "•"))
  )

(provide 'use-org-bullets)
;;; use-org-bullets.el ends here
