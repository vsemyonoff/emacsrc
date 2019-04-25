;;; use-editorconfig.el ---  cross-editor configuration. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'editorconfig))
    (warn "===> Can't install 'editorconfig'")

  ;; Triggers
  (add-hook 'vs-emacs-config-hook #'editorconfig-mode)
  )

(provide 'use-editorconfig)
;;; use-editorconfig.el ends here
