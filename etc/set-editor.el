;;; set-editor.el --- editor settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
;;
;; TODO: move some stuff to correcponding `use-package'
;; bookmarks
(require 'bookmark)
(setq bookmark-default-file (expand-file-name "bookmarks.el" vs-cache-dir)
      bookmark-save-flag    1)

;; dired - reuse current buffer by pressing 'a'
;(put 'dired-find-alternate-file 'disabled nil)
;(setq dired-recursive-deletes 'always)
;(setq dired-recursive-copies 'always)
;(setq dired-dwim-target t)
;(require 'dired-x)

;; ediff - don't start another frame
;(require 'ediff)
;(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; cleanup old buffers
;(require 'midnight)
;(midnight-mode t)

(require 'tabify)
(with-region-or-buffer indent-region)
(with-region-or-buffer untabify)

;; make a shell script executable automatically on save
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; whitespace-mode config
(require 'whitespace)
(setq whitespace-line-column 120) ;; limit line length
(setq whitespace-style '(face tabs empty trailing lines-tail))
(add-hook 'before-save-hook #'delete-trailing-whitespace)
(add-hook 'conf-mode-hook #'whitespace-mode)
(add-hook 'prog-mode-hook #'whitespace-mode)
(add-hook 'text-mode-hook #'whitespace-mode)

;; saner regex syntax
(require 're-builder)
(setq reb-re-syntax 'string)

(require 'eshell)
(setq eshell-directory-name (expand-file-name "eshell" vs-cache-dir))

(vs//require-dir (expand-file-name "editor" vs-config-dir))

(provide 'set-editor)
;;; set-editor.el ends here
