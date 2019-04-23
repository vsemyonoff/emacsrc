;;; use-lsp-mode.el ---  C/C++/HTML/Java/Python modes settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)
(require 'straight)

(if (not (straight-use-package 'lsp-mode))
    (warn "===> Can't install 'lsp-mode'")

  ;; Triggers
  (add-hook 'css-mode-hook    #'lsp)
  (add-hook 'html-mode-hook   #'lsp)
  (add-hook 'python-mode-hook #'lsp)

  ;; Config
  (with-eval-after-load 'lsp
    (setq lsp-auto-guess-root    t
          lsp-eldoc-enable-hover nil
          lsp-eldoc-render-all   nil
          lsp-inhibit-message    nil
          lsp-prefer-flymake     nil
          lsp-restart            'auto-restart
          lsp-session-file       (expand-file-name "lsp.session"
                                                   vs-emacs-cache-dir))
    )

  (if (not (straight-use-package 'lsp-ui))
      (warn "===> Can't install 'lsp-ui'")

    ;; Triggers/config
    (with-eval-after-load 'lsp
      (require 'lsp-ui)

      (add-hook 'lsp-ui-mode-hook (lambda () (eldoc-mode -1)))

      ;; Keybindings
      (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
      (define-key lsp-ui-mode-map [remap xref-find-references ] #'lsp-ui-peek-find-references )

      ;; Some settings
      (setq lsp-ui-doc-use-childframe         t
            lsp-ui-flycheck-enable            t
            lsp-ui-sideline-ignore-duplicate  t
            lsp-ui-sideline-show-code-actions nil
            lsp-ui-sideline-show-flycheck     t
            lsp-ui-sideline-show-hover        nil
            lsp-ui-sideline-show-symbol       nil
            lsp-ui-sideline-update-mode       'point)
      )
    )

  (with-eval-after-load 'company
    (if (not (straight-use-package 'company-lsp))
        (warn "===> Can't install 'company-lsp'")

      ;; Triggers/config
      (with-eval-after-load 'lsp
        (require 'company-lsp)

        (setq company-lsp-async            t
              company-lsp-enable-snippet   t
              company-lsp-cache-candidates nil)
        )
      )
    )

  (if (not (straight-use-package 'ccls))
      (warn "===> Can't install 'ccls'")

    ;; Triggers
    (defun vs|ccls/enable ()
      (require 'ccls)
      (lsp)
      )
    (add-hook 'c++-mode-hook    #'vs|ccls/enable)
    (add-hook 'c-mode-hook      #'vs|ccls/enable)
    (add-hook 'objc-mode-hook   #'vs|ccls/enable)

    ;; Config
    (with-eval-after-load 'ccls
      (setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t)))

      (with-eval-after-load 'projectile
        (add-to-list 'projectile-project-root-files-top-down-recurring ".ccls")
        (add-to-list 'projectile-project-root-files-bottom-up ".ccls")
        )
      )
    )

  (if (not (straight-use-package 'lsp-java))
      (warn "===> Can't install 'lsp-java'")

    ;; Triggers
    (defun vs|lsp-java/enable ()
      (require 'lsp-java)
      (lsp)
      )
    (add-hook 'java-mode-hook #'vs|lsp-java/enable)

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
