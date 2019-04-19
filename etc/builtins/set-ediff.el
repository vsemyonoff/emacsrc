;;; set-ediff.el ---  ediff settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(with-eval-after-load 'ediff
  (setq ediff-split-window-function 'split-window-horizontally
        ediff-window-setup-function 'ediff-setup-windows-plain)
  )

(provide 'set-ediff)
;;; set-ediff.el ends here
