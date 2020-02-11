;;; use-google-c-style.el ---  various utils. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package google-c-style
  :straight (:host github :repo "google/styleguide" :branch "gh-pages")
  :hook (c-mode-common . google-set-c-style)
  )

(provide 'use-google-c-style)
;;; use-google-c-style.el ends here
