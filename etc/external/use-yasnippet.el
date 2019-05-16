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
      (yasnippet-snippets-initialize)
      )

    (with-eval-after-load 'autoinsert
      (defun vs|autoinsert/yas-expand ()
        "Replace text in yasnippet template."
        (yas/expand-snippet (buffer-string) (point-min) (point-max))
        )

      (defun vs|autoinsert/find-file-template (filename &rest _)
        "Add template in `auto-insert-alist' for FILENAME."
        (let* ((base-name (file-name-nondirectory filename))
               (template  (or (file-name-extension base-name) base-name)))
          (add-to-list 'auto-insert-alist `(,(format "%s\\'" template) . [,template vs|autoinsert/yas-expand]))
          )
        )

      (advice-add 'find-file :before 'vs|autoinsert/find-file-template)

      )
    )
  )

(provide 'use-yasnippet)
;;; use-yasnippet.el ends here
