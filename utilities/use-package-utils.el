;;; use-package-utils.el ---  package manager utilities. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package package-utils
  :config
  (defun vs/packages-upgrade()
    (interactive)
    (alert (package-utils-upgrade-all) :title "Upgrade"))

  (defun vs/packages-upgrade-async()
    (interactive)
    (async-start
     `(lambda ()
	,(async-inject-variables "\\`\\(load-path\\|\\(package-.+\\)\\)")
	(require 'package-utils)
	(package-utils-upgrade-all))
     (lambda (&optional _ignore)
       (alert _ignore))))


  :general (:prefix "C-x" "u" 'packages-upgrade-async)
  )

(provide 'use-package-utils)
;;; use-package-utils.el ends here
