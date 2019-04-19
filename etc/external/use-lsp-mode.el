;;; use-lsp-mode.el ---  C/C++/HTML/Java/Python modes settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)
(require 'straight)
(require 'delight)

(defvar vs-java-projects (list)
  "Java projects to add in workspace.
Should be populated using `.dir-locals.el' like that:
\t((java-mode . ((vs-java-projects . (\"project1\" \"project2\")))))")

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
    (setq lsp-eldoc-render-all nil
          lsp-inhibit-message  nil)
    )

  (if (not (straight-use-package 'lsp-ui))
      (warn "===> Can't install 'lsp-ui'")

    ;; Triggers
    (with-eval-after-load 'lsp
      (require 'lsp-ui)
      )

    ;; Config
    (with-eval-after-load 'lsp-ui
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
            lsp-ui-sideline-update-mode       'point)
      )
    )

  (with-eval-after-load 'company
    (if (not (straight-use-package 'company-lsp))
        (warn "===> Can't install 'company-lsp'")

      ;; Triggers
      (with-eval-after-load 'lsp
        (require 'company-lsp)
        )

      ;; Config
      (with-eval-after-load 'company-lsp
        (setq company-lsp-async            t
              company-lsp-enable-snippet   t
              company-lsp-cache-candidates t)

        ;; ;; From cquery wiki page
        ;; (setq company-lsp-cache-candidates nil
        ;;       company-transformers         nil)
        )
      )
    )

  (if (not (straight-use-package 'cquery))
      (warn "===> Can't install 'cquery'")

    ;; Triggers
    (with-eval-after-load 'lsp
      (require 'cquery)
      )

    ;; Config
    (with-eval-after-load 'cquery
      (with-eval-after-load 'projectile
        (setq projectile-project-root-files-top-down-recurring
              (append '("compile_commands.json"
                        ".cquery")
                      projectile-project-root-files-top-down-recurring))
        )

      (setq cquery-extra-init-params    '(:index (:comments 2)
                                                 :cacheFormat "msgpack"
                                                 :completion (:detailedLabel t)))

      ;; ;; From cquery wiki page
      ;; (setq cquery-sem-highlight-method 'overlay)
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
      (setq lsp-java-server-install-dir (expand-file-name "eclipse/" vs-xdg-data-dir)
            lsp-java-workspace-cache-dir (expand-file-name "eclipse/" vs-xdg-cache-dir)
            lsp-java-workspace-dir (expand-file-name "eclipse/" vs-xdg-config-dir))

      (defun vs|lsp-java/before-enable ()
        "Populate `lsp-java' workspace with projects from `.dir-locals.el'."
        (vs|emacs|apply-dir-locals)
        (let ((projects ""))
          (mapc
           (lambda (element)
             (let ((project (expand-file-name element (projectile-project-root))))
               (when (file-exists-p project)
                 (add-to-list 'lsp-java--workspace-folders project)
                 (setq projects (concat projects " " project))
                 )
               )
             )
           vs-java-projects)
          (message "===> LSP Java: workspace projects:%s" projects))
        )
      (advice-add 'lsp-java-enable :before 'vs|lsp-java/before-enable)
      )
    )
  )

(if (not (straight-use-package 'modern-cpp-font-lock))
    (warn "===> Can't install 'modern-cpp-font-lock'")

  ;; Triggers
  (add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)

  ;; Config
  (with-eval-after-load 'modern-c++-font-lock
    (delight 'modern-c++-font-lock-mode nil 'modern-cpp-font-lock)
    )
  )

(provide 'use-lsp-mode)
;;; use-lsp-mode.el ends here
