;;; use-w3m.el --- Emacs w3m wrapper. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'w3m))
    (warn "===> Can't install 'w3m'")

  (setq mm-text-html-renderer 'w3m)
  )

(provide 'use-w3m)
;;; use-w3m.el ends here
