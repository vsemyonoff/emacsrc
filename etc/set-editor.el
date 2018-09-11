;;; set-editor.el --- editor settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
;;
;; TODO: move some stuff to correcponding `use-package'
;; bookmarks
(require 'bookmark)
(setq bookmark-default-file (expand-file-name "bookmarks.el" vs-emacs-cache-dir)
      bookmark-save-flag    1)

;; ediff - don't start another frame
(require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; cleanup old buffers
(require 'midnight)
(midnight-mode t)

;; saner regex syntax
(require 're-builder)
(setq reb-re-syntax 'string)

(require 'eshell)
(setq eshell-directory-name (expand-file-name "eshell" vs-emacs-cache-dir))

(vs|emacs/require-dir (expand-file-name "editor" vs-emacs-config-dir))

(provide 'set-editor)
;;; set-editor.el ends here
