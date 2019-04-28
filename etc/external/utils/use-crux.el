;;; use-crux.el ---  various utils. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'crux))
    (warn "===> Can't install 'crux'")

  ;; Triggets
  (require 'crux)

  ;; Config
  (crux-with-region-or-buffer indent-region)
  (crux-with-region-or-buffer untabify)
  (crux-with-region-or-line comment-or-uncomment-region)
  )

(provide 'use-crux)
;;; use-crux.el ends here
