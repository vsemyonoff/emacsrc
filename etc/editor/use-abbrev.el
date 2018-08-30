;;; use-abbrev.el ---  abbrev mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package abbrev :ensure nil :delight
  :config (setq abbrev-file-name (expand-file-name "abbrev.el" vs-emacs-cache-dir))
  :hook (text-mode . abbrev-mode))

(provide 'use-abbrev)
;;; set-abbrev.el ends here
