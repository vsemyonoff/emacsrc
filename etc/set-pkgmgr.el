;;; set-pkgmgr.el --- package manager settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'package)

;; Package manager settings
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
(setq package-user-dir (expand-file-name "packages" vs-emacs-cache-dir)
      package-gnupghome-dir (expand-file-name "gnupg" package-user-dir))

;; Init package manager
(package-initialize)

;; Refresh packages cache
(unless package-archive-contents
  (package-refresh-contents))

;; Install quelpa-use-package
(unless (package-installed-p 'quelpa-use-package)
  (package-install 'quelpa-use-package))
(setq quelpa-dir (expand-file-name "archives/quelpa" package-user-dir)
      quelpa-checkout-melpa-p nil
      quelpa-update-melpa-p nil
      use-package-always-ensure t)
(eval-when-compile
  (require 'quelpa-use-package))

;; Install other package-related stuff
(vs|emacs/require-dir (expand-file-name "pkgmgr" vs-emacs-config-dir))

(provide 'set-pkgmgr)
;;; set-pkgmgr.el ends here
