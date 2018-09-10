;;; use-lsp-mode.el ---  C/C++/Java modes settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package cmake-ide
  :after use-projectile
  :commands (cmake-ide-compile cmake-ide-maybe-run-cmake cmake-ide-run-cmake cmake-ide-setup)
  :config
  (progn
    (require 'projectile)
    (defun vs|cmake-ide/set-build-dir ()
      (setq cmake-ide-build-dir (condition-case nil
                                    (expand-file-name "build/debug"
                                                      (projectile-project-root))
                                  (error nil))
            cmake-ide-cmake-opts "-DCMAKE_BUILD_TYPE=Debug"))
    (advice-add 'cmake-ide-compile :before 'vs|cmake-ide/set-build-dir)
    (advice-add 'cmake-ide-maybe-run-cmake :before 'vs|cmake-ide/set-build-dir)
    (advice-add 'cmake-ide-run-cmake :before 'vs|cmake-ide/set-build-dir)
    (advice-add 'cmake-ide-setup :after 'vs|cmake-ide/set-build-dir))

  :hook
  ((c-initialization                . cmake-ide-setup            )
   (projectile-after-switch-project . vs|cmake-ide/set-build-dir)))


(use-package lsp-mode
  :after cmake-ide

  :config
  (progn
    (setq lsp-eldoc-render-all          nil
          lsp-highlight-symbol-at-point nil
          lsp-inhibit-message           t  )

    (lsp-define-stdio-client lsp-clangd-c++
                             "cpp"
                             'projectile-project-root
                             nil
                             :ignore-regexps
                             '("^Error -[0-9]+: .+$")
                             :command-fn
                             (lambda ()
                               (list (if running-on-macos "/usr/local/opt/llvm/bin/clangd" "clangd")
                                     (concat "--compile-commands-dir=" (or cmake-ide-build-dir
                                                                           cmake-ide-build-pool-dir))))))

  :hook (c++-mode . lsp-clangd-c++-enable))


(use-package lsp-java
  :config
  (setq lsp-java--workspace-folders (list "~/Sources/pinch")
        lsp-java-server-install-dir (expand-file-name "eclipse.jdt.ls/" vs-xdg-data-dir)
        lsp-java-workspace-cache-dir (expand-file-name "eclipse.jdt.ls/" vs-xdg-cache-dir)
        lsp-java-workspace-dir (expand-file-name "Documents/Eclipse/" vs-user-home-dir))

  :hook (java-mode . lsp-java-enable))


(use-package lsp-ui
  :config
  (progn
    (setq lsp-ui-doc-enable                 nil
          lsp-ui-sideline-ignore-duplicate  t
          lsp-ui-sideline-show-code-actions t
          lsp-ui-sideline-show-flycheck     t
          lsp-ui-sideline-show-hover        nil
          lsp-ui-sideline-show-symbol       t
          lsp-ui-sideline-update-mode       'point)

    (defun vs|lsp-ui/eldoc-disable ()
      (eldoc-mode -1)))

  :general
  (lsp-ui-mode-map [remap xref-find-definitions] 'lsp-ui-peek-find-definitions
                   [remap xref-find-references]  'lsp-ui-peek-find-references )

  :hook
  ((lsp-mode . lsp-ui-mode            )
   (c++-mode . vs|lsp-ui/eldoc-disable)))


(use-package company-lsp
  :after company

  :config
  (progn
    (setq company-lsp-enable-snippet   t
          company-lsp-cache-candidates t)

    (defun vs|company/lsp-setup()
      (add-to-list 'company-backends 'company-lsp)))

  :hook (lsp-mode . vs|company/lsp-setup))



(use-package modern-cpp-font-lock :delight
  :commands modern-c++-font-lock-mode
  :hook (c++-mode . modern-c++-font-lock-mode))


(provide 'use-lsp-mode)
;;; use-lsp-mode.el ends here
