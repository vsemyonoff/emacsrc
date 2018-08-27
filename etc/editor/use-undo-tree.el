;;; use-undo-tree.el ---  more natural `undo' behavior. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package undo-tree
  :delight (undo-tree-mode " ⟲")
  :config
  (let ((undo-tree-dir
         (expand-file-name
          (convert-standard-filename "undosave/") vs-cache-dir)))
    (setq undo-tree-auto-save-history       t
          undo-tree-history-directory-alist `((".*" . ,undo-tree-dir)))

    (unless (file-exists-p undo-tree-dir)
      (make-directory undo-tree-dir)))


  :hook ((vs-config  . global-undo-tree-mode      )
         (find-file  . undo-tree-load-history-hook)
         (write-file . undo-tree-save-history-hook))
  )

(provide 'use-undo-tree)
;;; use-undo-tree.el ends here
