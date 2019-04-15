;;; use-crux.el ---  various utils. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)

(straight-use-package 'crux)

;; Triggets
(require 'crux)

;; Config
(crux-with-region-or-buffer indent-region)
(crux-with-region-or-buffer untabify)
(crux-with-region-or-line comment-or-uncomment-region)

(provide 'use-crux)
;;; use-crux.el ends here
