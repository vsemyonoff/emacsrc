;;; use-lua-mode.el ---  Lua editing mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)

(if (not (straight-use-package 'lua-mode))
    (warn "===> Can't install 'lua-mode'")

  ;; Triggets
  (autoload 'lua-mode "lua-mode" "Lua editing mode." t)
  (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
  (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

  (with-eval-after-load 'company
    (if (not (straight-use-package 'company-lua))
        (warn "===> Can't install 'company-lsp'")
      ;; Triggers
      (defun vs|company-lua/enable ()
        (make-local-variable 'company-backends)
        (push 'company-lua company-backends)
        )
      (add-hook 'lua-mode-hook #'vs|company-lua/enable)
      )
    )
  )

(provide 'use-lua-mode)
;;; use-lua-mode.el ends here
