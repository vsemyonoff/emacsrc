;;; use-package-utils.el ---  package manager utilities. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package package-utils
  :config
  (progn
    (defun vs/packages-upgrade ()
      (interactive)
      (alert (package-utils-upgrade-all) :title "Upgrade"))

    (defun vs/packages-upgrade-async ()
      (interactive)
      (async-start
       `(lambda ()
	      ,(async-inject-variables "\\`\\(load-path\\|\\(package-.+\\)\\)")
	      (require 'package-utils)
	      (package-utils-upgrade-all))
       (lambda (&optional done)
         (alert done))))))

(provide 'use-package-utils)
;;; use-package-utils.el ends here
