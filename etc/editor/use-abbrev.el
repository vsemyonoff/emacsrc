;;; use-abbrev.el ---  abbrev mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package abbrev :ensure nil
  :config (setq abbrev-file-name (expand-file-name "abbrev.el" vs-cache-dir))
  :hook (text-mode . abbrev-mode)
  )

(provide 'use-abbrev)
;;; set-abbrev.el ends here
