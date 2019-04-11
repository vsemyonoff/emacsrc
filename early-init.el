;;; early-init.el --- new place to set up `package.el'. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'xdg)

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
(setq package-user-dir (expand-file-name "emacs/packages" (xdg-cache-home))
      package-gnupghome-dir (expand-file-name "gnupg" package-user-dir))

;; Don't init  `package.el', will use `straight.el' instead
(setq package-enable-at-startup nil)

(provide 'early-init)
;;; early-init.el ends here
