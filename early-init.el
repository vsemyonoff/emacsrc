;;; early-init.el --- Emacs configuration entry point (since Emacs v27). -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(setq user-emacs-directory (file-name-directory (or load-file-name (buffer-file-name))))
(add-to-list 'load-path
             (expand-file-name "etc" user-emacs-directory))

;; Package repos
(setq package-archives
      '(;("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa"        . "https://melpa.org/packages/")
        ("elpa"         . "https://elpa.gnu.org/packages/")
        ("org"          . "https://orgmode.org/elpa/"))
      package-archive-priorities
      '(;("melpa-stable" . 50)
        ("melpa"        . 30)
        ("org"          . 15)
        ("elpa"         . 0)))

;; Packages location
(require 'set-config)
(setq package-user-dir (expand-file-name "packages" vs-emacs-cache-dir)
      package-gnupghome-dir (expand-file-name "gnupg" package-user-dir))

;; Don't init  `package.el', will use `straight.el' instead
(setq package-enable-at-startup nil)

(provide 'early-init)
;;; early-init.el ends here
