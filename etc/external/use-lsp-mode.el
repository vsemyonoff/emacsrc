;;; use-lsp-mode.el ---  C/C++/HTML/Java/Python modes settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)
(require 'straight)
(require 'delight)

(if (not (straight-use-package 'lsp-mode))
    (warn "===> Can't install 'lsp-mode'")

  ;; Triggers
  (add-hook 'c++-mode-hook    #'lsp)
  (add-hook 'c-mode-hook      #'lsp)
  (add-hook 'css-mode-hook    #'lsp)
  (add-hook 'html-mode-hook   #'lsp)
  (add-hook 'java-mode-hook   #'lsp)
  (add-hook 'python-mode-hook #'lsp)

  ;; Config
  (with-eval-after-load 'lsp
    (with-eval-after-load 'projectile
      (add-to-list 'projectile-project-root-files-top-down-recurring
                   "compile_commands.json")
      )

    (setq lsp-eldoc-enable-hover nil
          lsp-eldoc-render-all   nil
          lsp-inhibit-message    nil)

    )

  (if (not (straight-use-package 'lsp-ui))
      (warn "===> Can't install 'lsp-ui'")

    ;; Triggers
    (with-eval-after-load 'lsp
      (add-hook 'lsp-mode-hook #'lsp-ui-mode)
      )

    ;; Config
    (with-eval-after-load 'lsp-ui
      ;; Disable `eldoc-mode' when `lsp-ui-mode' enabled
      (add-hook 'lsp-ui-mode-hook (lambda () (eldoc-mode -1)))

      ;; Keybindings
      (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
      (define-key lsp-ui-mode-map [remap xref-find-references ] #'lsp-ui-peek-find-references )

      ;; Some settings
      (setq lsp-ui-doc-use-childframe         t
            lsp-ui-sideline-ignore-duplicate  t
            lsp-ui-sideline-show-code-actions nil
            lsp-ui-sideline-show-flycheck     t
            lsp-ui-sideline-show-hover        nil
            lsp-ui-sideline-show-symbol       t
            lsp-ui-sideline-show-symbol       nil
            lsp-ui-sideline-update-mode       'point)
      )
    )

  (with-eval-after-load 'company
    (if (not (straight-use-package 'company-lsp))
        (warn "===> Can't install 'company-lsp'")

      ;; Triggers
      (with-eval-after-load 'lsp
        (defun vs|company-lsp/enable()
          (make-local-variable 'company-backends)
          (push 'company-lsp company-backends)
          )
        (add-hook 'lsp-mode-hook #'vs|company-lsp/enable)
        )

      ;; Config
      (with-eval-after-load 'company-lsp
        ;; ;; From cquery wiki page
        ;; (setq company-lsp-cache-candidates nil
        ;;       company-transformers         nil)
        (setq company-lsp-async            t
              company-lsp-enable-snippet   t
              company-lsp-cache-candidates t)
        )
      )
    )

  (if (not (straight-use-package 'lsp-java))
      (warn "===> Can't install 'lsp-java'")

    ;; Triggers
    (with-eval-after-load 'lsp
      (require 'lsp-java)
      )

    ;; Config
    (with-eval-after-load 'lsp-java
      (setq lsp-java-server-install-dir  (expand-file-name "eclipse/" vs-xdg-data-dir  )
            lsp-java-workspace-cache-dir (expand-file-name "eclipse/" vs-xdg-cache-dir )
            lsp-java-workspace-dir       (expand-file-name "eclipse/" vs-xdg-config-dir))
      )
    )
  )

(provide 'use-lsp-mode)
;;; use-lsp-mode.el ends here
