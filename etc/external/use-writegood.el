;;; use-writegood.el ---  writer mode tweak. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)
(require 'delight)

(if (not (straight-use-package 'writegood-mode))
    (warn "===> Can't install 'writegood-mode'")

  ;; Triggers
  (add-hook 'markdown-mode-hook  #'writegood-mode)
  (add-hook 'org-mode-hook       #'writegood-mode)
  (add-hook 'text-mode-hook      #'writegood-mode)
  )

(provide 'use-writegood)
;;; use-writegood.el ends here
