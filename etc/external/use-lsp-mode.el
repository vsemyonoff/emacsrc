;;; use-lsp-mode.el ---  C/C++/HTML/Java/Python modes settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package lsp-mode
  :after use-projectile
  :init (setq lsp-keymap-prefix "C-c l")
  :hook ((c-mode c++-mode cmake-mode css-mode html-mode objc-mode python-mode sh-mode) . lsp)
  :config
  (setq lsp-auto-guess-root                  t
        lsp-auto-configure                   t
        lsp-enable-semantic-highlighting     t
        lsp-restart                          'auto-restart
        lsp-session-file                     (vs:emacs/cache "session.lsp")
        lsp-symbol-highlighting-skip-current t
        lsp-clients-clangd-args              `("-j=4" "--background-index"
                                              "--clang-tidy" "--suggest-missing-includes"
                                              "-log=error"
                                              ,(format "--compile-commands-dir=%sbuild"
                                                       (projectile-project-root))))
  :commands lsp
  )

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :bind
  (:map lsp-ui-mode-map
        ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
        ([remap xref-find-references ] . lsp-ui-peek-find-references ))
  :config
  (setq lsp-ui-sideline-ignore-duplicate  t
        lsp-ui-sideline-show-code-actions nil
        lsp-ui-sideline-show-diagnostics  t
        lsp-ui-sideline-show-hover        nil
        lsp-ui-sideline-show-symbol       nil
        lsp-ui-sideline-update-mode       'point)
  :commands lsp-ui-mode
  )

(use-package company-lsp
  :config
  (setq company-lsp-async            t
        company-lsp-enable-snippet   t
        company-lsp-cache-candidates nil)
  :commands comapny-lsp
  )

(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol
  )

(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list
  )

(provide 'use-lsp-mode)
;;; use-lsp-mode.el ends here
