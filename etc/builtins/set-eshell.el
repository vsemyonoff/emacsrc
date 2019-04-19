;;; set-eshell.el ---  Emacs shell settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)

(with-eval-after-load 'eshell
  (setq eshell-directory-name (expand-file-name "eshell" vs-emacs-cache-dir))
  )

(provide 'set-eshell)
;;; set-eshell.el ends here
