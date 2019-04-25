;;; use-yasnippet.el ---  YASnippet mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'yasnippet))
    (warn "===> Can't install 'yasnippet'")

  ;; Triggers
  (add-hook 'vs-emacs-config-hook  #'yas-global-mode)

  ;; Config
  (with-eval-after-load 'yasnippet
    (setq yas-snippet-dirs (list (vs|emacs/data "snippets")))

    (if (not (straight-use-package 'yasnippet-snippets))
        (warn "===> Can't install 'yasnippet-snippets'")
      ;; Trigger
      (require 'yasnippet-snippets)
      )
    )
  )

(provide 'use-yasnippet)
;;; use-yasnippet.el ends here
