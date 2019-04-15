;;; use-undo-tree.el ---  more natural `undo' behavior. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)
(require 'delight)

(straight-use-package 'undo-tree)
;; Triggers
(add-hook 'vs-emacs-config-hook #'global-undo-tree-mode)
;; Delight
(delight 'undo-tree-mode nil 'undo-tree)

(provide 'use-undo-tree)
;;; use-undo-tree.el ends here
