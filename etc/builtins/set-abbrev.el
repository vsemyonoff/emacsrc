;;; set-abbrev.el ---  abbrev mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(add-hook 'text-mode-hook #'abbrev-mode)

(with-eval-after-load 'abbrev
  (setq abbrev-file-name (vs:emacs/cache "abbrev.el"))
  )

(provide 'set-abbrev)
;;; set-abbrev.el ends here
