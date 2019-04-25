;;; use-undo-tree.el ---  more natural `undo' behavior. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'undo-tree))
    (warn "===> Can't install 'undo-tree'")

  ;; Triggers
  (add-hook 'vs-emacs-config-hook #'global-undo-tree-mode)
  )

(provide 'use-undo-tree)
;;; use-undo-tree.el ends here
