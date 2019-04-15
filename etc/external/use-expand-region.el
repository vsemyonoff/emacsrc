;;; use-expand-region.el ---  expand region mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)

(straight-use-package 'expand-region)
;; Keybindings
(define-key (current-global-map) (kbd "C-M-=") #'er/contract-region)
(define-key (current-global-map) (kbd "C-="  ) #'er/expand-region  )

(provide 'use-expand-region)
;;; use-expand-region.el ends here
