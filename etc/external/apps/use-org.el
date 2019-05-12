;;; use-org.el --- Org mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'org))
    (warn "===> Can't install 'org-mode'")

  (if (not (straight-use-package 'org-bullets))
      (warn "===> Can't install 'org-bullets'")

    (add-hook 'org-mode-hook #'org-bullets-mode)

    (with-eval-after-load 'org-bullets
      (setq org-bullets-bullet-list `(,(all-the-icons-material "radio_button_checked")
                                      ,(all-the-icons-material "adjust")
                                      ,(all-the-icons-material "radio_button_unchecked")
                                      ,(all-the-icons-material "stars")
                                      ,(all-the-icons-material "star")
                                      ,(all-the-icons-material "star_border")
                                      "⚫" "⚪" "⚬"
                                      )
            )
      )
    )

  (add-hook 'org-mode-hook #'visual-line-mode)

  (with-eval-after-load 'org
    (setq org-ellipsis "▼")
    )
  )

(provide 'use-org)
;;; use-org.el ends here
