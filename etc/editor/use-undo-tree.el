;;; use-undo-tree.el ---  more natural `undo' behavior. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package undo-tree :delight :ensure quelpa
  :config (global-undo-tree-mode)
  :quelpa (undo-tree :fetcher git :url "http://www.dr-qubit.org/git/undo-tree.git"))


(provide 'use-undo-tree)
;;; use-undo-tree.el ends here
