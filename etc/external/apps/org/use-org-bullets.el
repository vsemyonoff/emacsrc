;;; use-org-bullets.el --- Pretty org-mode bullets. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(with-eval-after-load 'org
  (if (not (straight-use-package 'org-bullets))
      (warn "===> Can't install 'org-bullets'")

    (add-hook 'org-mode-hook #'org-bullets-mode)

    (with-eval-after-load 'org-bullets
      (setq org-bullets-bullet-list `(,(all-the-icons-faicon "dot-circle-o")
                                      "☉" "⚫" "⚬" "•"))
      )
    )
  )

(provide 'use-org-bullets)
;;; use-org-bullets.el ends here
