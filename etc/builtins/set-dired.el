;;; set-dired.el ---  dired mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(with-eval-after-load 'dired
  (require 'dired-x)

  (setq dired-dwim-target       t
        dired-recursive-copies  'always
        dired-recursive-deletes 'top   )

  (put 'dired-find-alternate-file 'disabled nil))

(provide 'set-dired)
;;; set-dired.el ends here
