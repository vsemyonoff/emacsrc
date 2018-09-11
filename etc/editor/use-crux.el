;;; use-crux.el ---  various utils. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package crux :delight
  :config
  (progn
    (crux-with-region-or-buffer indent-region)
    (crux-with-region-or-buffer untabify)
    (crux-with-region-or-line comment-or-uncomment-region))

  :hook (vs-emacs-config . crux-reopen-as-root-mode))


(provide 'use-crux)
;;; use-crux.el ends here
