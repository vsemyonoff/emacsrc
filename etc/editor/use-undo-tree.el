;;; use-undo-tree.el ---  more natural `undo' behavior. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package undo-tree :delight :pin melpa :disabled
  :config
  (progn
    (let ((undo-tree-dir
           (expand-file-name
            (convert-standard-filename "undosave/") vs-emacs-cache-dir)))
      (setq undo-tree-auto-save-history       t
            undo-tree-history-directory-alist `((".*" . ,undo-tree-dir)))

      (unless (file-exists-p undo-tree-dir)
        (make-directory undo-tree-dir)))

    (defalias 'redo 'undo-tree-redo)
    (global-set-key (kbd "C-S-z") 'redo)
    (global-set-key (kbd "C-z") 'undo))

  :hook ((vs-emacs-config  . global-undo-tree-mode      )
         (find-file        . undo-tree-load-history-hook)
         (write-file       . undo-tree-save-history-hook)))

(provide 'use-undo-tree)
;;; use-undo-tree.el ends here
