;;; use-lsp-mode.el ---  C/C++/HTML/Java/Python modes settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(defvar vs-java-projects (list)
  "Java projects to add in workspace.
Should be populated using `.dir-locals.el' like that:
\t((java-mode . ((vs-java-projects . (\"project1\" \"project2\")))))")


(use-package lsp-mode
  :config
  (setq lsp-eldoc-render-all          nil
        lsp-inhibit-message           nil)
  :hook (prog-mode . lsp))


;;(use-package cquery :after lsp)


(use-package lsp-java
  :after lsp
  :config
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
  (advice-add 'lsp-java-enable :before 'vs|lsp-java/before-enable))


(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-use-childframe         nil
        lsp-ui-sideline-ignore-duplicate  t
        lsp-ui-sideline-show-code-actions t
        lsp-ui-sideline-show-flycheck     t
        lsp-ui-sideline-show-hover        nil
        lsp-ui-sideline-show-symbol       t
        lsp-ui-sideline-update-mode       'point)

  :general
  (lsp-ui-mode-map
   [remap xref-find-definitions] 'lsp-ui-peek-find-definitions
   [remap xref-find-references]  'lsp-ui-peek-find-references ))


(use-package company-lsp
  :commands company-lsp
  :config
  (setq company-lsp-enable-snippet   t
        company-lsp-cache-candidates t))


(use-package modern-cpp-font-lock ;;:delight
  :hook (c++-mode . modern-c++-font-lock-mode))


(provide 'use-lsp-mode)
;;; use-lsp-mode.el ends here
