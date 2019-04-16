;;; set-dired.el ---  dired mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(with-eval-after-load 'dired
  (add-hook 'dired-mode-hook (lambda () (require 'dired-x)))
  (setq dired-dwim-target       t
        dired-listing-switches  "--group-directories-first -bhlvAF"
        dired-recursive-copies  'always
        dired-recursive-deletes 'top)
  (put 'dired-find-alternate-file 'disabled nil))


(provide 'set-dired)
;;; set-dired.el ends here
