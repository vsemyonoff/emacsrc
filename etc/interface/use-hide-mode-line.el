;;; use-hide-mode-line.el ---  hide mode line if unneeded. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package hide-mode-line
  :hook ((completion-list-mode . hide-mode-line-mode)
         ;;(help-mode            . hide-mode-line-mode)
         ;;(messages-buffer-mode . hide-mode-line-mode)
         ;;(treemacs-mode        . hide-mode-line-mode)
         ))

(provide 'use-hide-mode-line)
;;; use-hide-mode-line.el ends here
