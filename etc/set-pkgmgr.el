;;; set-pkgmgr.el --- package manager settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'quelpa-use-package)
  (package-install 'quelpa-use-package))

(setq-default quelpa-dir                (expand-file-name "archives/quelpa" package-user-dir)
              quelpa-checkout-melpa-p   nil
              quelpa-update-melpa-p     nil
              use-package-always-ensure t
              use-package-debug         t)

(eval-when-compile
  (require 'quelpa-use-package))

;; Install other package-related stuff
(vs|emacs/require-dir (expand-file-name "pkgmgr" vs-emacs-config-dir))

(provide 'set-pkgmgr)
;;; set-pkgmgr.el ends here
