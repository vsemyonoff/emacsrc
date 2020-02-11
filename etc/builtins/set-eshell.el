;;; set-eshell.el ---  Emacs shell settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(with-eval-after-load 'eshell
  (setq eshell-directory-name (vs:emacs/cache "eshell"))
  )

(provide 'set-eshell)
;;; set-eshell.el ends here
