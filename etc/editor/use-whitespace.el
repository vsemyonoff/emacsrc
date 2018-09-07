;;; use-whitespace.el ---  unneded spaces highlight and cleanup. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package whitespace :delight
  :config
  (setq whitespace-line-column 120
        whitespace-style       '(face tabs empty trailing lines-tail))

  :hook
  ((before-save . delete-trailing-whitespace)
   (conf-mode   . whitespace-mode           )
   (prog-mode   . whitespace-mode           )
   (text-mode   . whitespace-mode           )))


(provide 'use-whitespace)
;;; use-whitespace.el ends here
