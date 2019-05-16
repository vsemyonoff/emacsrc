;;; set-auto-insert.el ---  auto-insert mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(add-hook 'vs-emacs-config-hook #'auto-insert-mode)

(with-eval-after-load 'autoinsert
  (setq auto-insert           'other
        auto-insert-alist     nil
        auto-insert-directory (vs|emacs/data "templates")
        auto-insert-query     nil
        )
  )

(provide 'set-auto-insert)
;;; set-auto-insert.el ends here
