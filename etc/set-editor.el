;;; set-editor.el --- editor settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
;;
;; TODO: move some stuff to correcponding `use-package'
;; bookmarks
(require 'bookmark)
(setq bookmark-default-file (expand-file-name "bookmarks.el" vs-emacs-cache-dir)
      bookmark-save-flag    1)

(require 'dired)
(setq dired-dwim-target       t
      dired-recursive-copies  'always
      dired-recursive-deletes 'top)
;; dired - reuse current buffer by pressing 'a'
(put 'dired-find-alternate-file 'disabled nil)
(require 'dired-x)

;; ediff - don't start another frame
(require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; cleanup old buffers
(require 'midnight)
(midnight-mode t)

(require 'tabify)
(with-region-or-buffer indent-region)
(with-region-or-buffer untabify)

;; make a shell script executable automatically on save
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; saner regex syntax
(require 're-builder)
(setq reb-re-syntax 'string)

(require 'eshell)
(setq eshell-directory-name (expand-file-name "eshell" vs-emacs-cache-dir))

(vs//require-dir (expand-file-name "editor" vs-emacs-config-dir))

(provide 'set-editor)
;;; set-editor.el ends here
