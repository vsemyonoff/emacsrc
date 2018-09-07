;;; use-expand-region.el ---  expand region mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package expand-region
  :config
  (progn
    (global-set-key (kbd "C-M-=") 'er/contract-region)
    (global-set-key (kbd "C-=") 'er/expand-region)))


(provide 'use-expand-region)
;;; use-expand-region.el ends here
