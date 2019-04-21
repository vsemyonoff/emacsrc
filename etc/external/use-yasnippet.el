;;; use-yasnippet.el ---  YASnippet mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)
(require 'straight)
;; (require 'delight)

(if (not (straight-use-package 'yasnippet))
    (warn "===> Can't install 'yasnippet'")

  ;; Triggers
  (add-hook 'vs-emacs-config-hook  #'yas-global-mode)

  ;; Config
  (with-eval-after-load 'yasnippet
    (setq yas-snippet-dirs nil)         ; cleanup defaults first
    (push (expand-file-name "snippets" vs-emacs-data-dir)
          yas-snippet-dirs)

    (if (not (straight-use-package 'yasnippet-snippets))
        (warn "===> Can't install 'yasnippet-snippets'")
      ;; Trigger
      (require 'yasnippet-snippets)
      )
    )
  )

(provide 'use-yasnippet)
;;; use-yasnippet.el ends here
