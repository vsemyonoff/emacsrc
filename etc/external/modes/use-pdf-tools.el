;;; use-pdf-tools.el ---  PDF mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'pdf-tools))
    (warn "===> Can't install 'pdf-tools'")

  ;; (pdf-tools-install)

  (with-eval-after-load 'pdf-tools
    (setq-default pdf-view-display-size 'fit-width)
    )
  )

(provide 'use-pdf-tools)
;;; use-pdf-tools.el ends here
