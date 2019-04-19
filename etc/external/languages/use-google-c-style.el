;;; use-google-c-style.el ---  various utils. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)

(if (not (straight-use-package '(google-c-style :host github :repo "google/styleguide" :branch "gh-pages")))
    (warn "===> Can't install 'google-c-style'")

  ;; Triggets
  (add-hook 'c-mode-common-hook #'google-set-c-style)
  )

(provide 'use-google-c-style)
;;; use-google-c-style.el ends here
