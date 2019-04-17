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

(when (straight-use-package 'lsp-mode)
  ;; Triggers
  (add-hook 'css-mode-hook    #'lsp)
  (add-hook 'html-mode-hook   #'lsp)
  (add-hook 'python-mode-hook #'lsp)
  ;; Config
  (with-eval-after-load 'lsp
    (setq lsp-auto-configure   nil
          lsp-eldoc-render-all nil
          lsp-inhibit-message  nil))

  (when (straight-use-package 'lsp-ui)
    ;; Triggers
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)
    ;; Config
    (with-eval-after-load 'lsp-ui
      ;; Keybindings
      (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
      (define-key lsp-ui-mode-map [remap xref-find-references ] #'lsp-ui-peek-find-references )
      ;; Some settings
      (setq lsp-ui-doc-use-childframe         nil
            lsp-ui-sideline-ignore-duplicate  t
            lsp-ui-sideline-show-code-actions t
            lsp-ui-sideline-show-flycheck     t
            lsp-ui-sideline-show-hover        nil
            lsp-ui-sideline-show-symbol       t
            lsp-ui-sideline-update-mode       'point)))

  (with-eval-after-load 'company
    (when (straight-use-package 'company-lsp)
      ;; Triggers
      (defun vs|company-lsp/enable ()
        (require 'company-lsp)
        (push 'company-lsp company-backends))
      (add-hook 'lsp-mode #'vs|cmpany-lsp/enable)
      ;; Config
      (with-eval-after-load 'company-lsp
        (setq company-lsp-enable-snippet   t
              company-lsp-cache-candidates t))))

  (when (straight-use-package 'cquery)
    ;; Triggers
    (defun vs|cquery/enable ()
      (require 'cquery)
      (condition-case nil
          (lsp)
        (user-error nil)))
    (add-hook 'c++-mode-hook #'vs|cquery/enable)
    (add-hook 'c-mode-hook   #'vs|cquery/enable))

  (when (straight-use-package 'lsp-java)
    ;; Triggers
    (add-hook 'java-mode-hook   #'lsp)
    ;; Config
    (with-eval-after-load 'lsp-java
      (setq lsp-java-server-install-dir (expand-file-name "eclipse.jdt.ls/" vs-xdg-data-dir)
            lsp-java-workspace-cache-dir (expand-file-name "eclipse.jdt.ls/" vs-xdg-cache-dir)
            lsp-java-workspace-dir (expand-file-name "eclipse.jdt.ls/" vs-xdg-config-dir))
      (defun vs|lsp-java/before-enable ()
        "Populate `lsp-java' workspace with projects from `.dir-locals.el'."
        (vs|emacs|apply-dir-locals)
        (let ((projects ""))
          (mapc
           (lambda (element)
             (let ((project (expand-file-name element (projectile-project-root))))
               (when (file-exists-p project)
                 (add-to-list 'lsp-java--workspace-folders project)
                 (setq projects (concat projects " " project)))))
           vs-java-projects)
          (message "===> LSP Java: workspace projects:%s" projects)))
      (advice-add 'lsp-java-enable :before 'vs|lsp-java/before-enable))))

(when (straight-use-package 'modern-cpp-font-lock)
  ;; Triggers
  (add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)
  ;; Delight
  (delight 'modern-c++-font-lock-mode nil 'modern-cpp-font-lock))

(provide 'use-lsp-mode)
;;; use-lsp-mode.el ends here
