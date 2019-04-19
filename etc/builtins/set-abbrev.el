;;; set-abbrev.el ---  abbrev mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)

;; Triggers
(add-hook 'text-mode-hook #'abbrev-mode)
;; Config
(with-eval-after-load 'abbrev
  (setq abbrev-file-name (expand-file-name "abbrev.el" vs-emacs-cache-dir))
  )

(provide 'set-abbrev)
;;; set-abbrev.el ends here
