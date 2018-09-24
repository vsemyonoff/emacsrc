;;; use-lsp-mode.el ---  C/C++/HTML/Java/Python modes settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(defvar-local vs-cmake-build-dir "build"
  "`cmake' out of source build path relative to project's root.

Can be changed using `.dir-locals.el' like that:
\t((c-mode . ((vs-cmake-build-dir . \"../build\"))))")


(defvar-local vs-cmake-build-type "Debug"
  "`cmake' project build type: Debug, Release, RelWithDebInfo.

Can be changed using `.dir-locals.el' like that:
\t((c-mode . ((vs-cmake-build-type . \"Release\"))))")


(defvar-local vs-java-projects (list)
  "Java projects to add in workspace.

Should be populated using `.dir-locals.el' like that:
\t((java-mode . ((vs-java-projects . (\"project1\" \"project2\")))))")


(use-package cmake-ide
  :after use-projectile
  :commands cmake-ide-setup
  :config
  (defun vs|cmake-ide/prepare-symlink ()
    "Create symlink for 'compile_commands.json' in top-level build directory."
    (let* ((src-json (expand-file-name "compile_commands.json" cmake-ide-build-dir))
           (build-dir (file-name-directory cmake-ide-build-dir))
           (dst-json (expand-file-name "compile_commands.json" build-dir)))
      (unless (string= src-json dst-json)
        (unless (file-exists-p build-dir)
          (make-directory build-dir t))
        (when (file-exists-p dst-json)
          (delete-file dst-json))
        (make-symbolic-link src-json dst-json)
        (message "===> Cmake IDE: %s -> %s" src-json dst-json))))

  (defun vs|cmake-ide/before-maybe-run-cmake()
    "Set `cmake' build configuration from `.dir-locals.el'."
    (when (string= (projectile-project-type) "cmake")
      (vs|emacs|apply-dir-locals)
      (let ((build-dir (format "%s/%s" vs-cmake-build-dir (downcase vs-cmake-build-type))))
        (setq cmake-ide-project-dir (directory-file-name (projectile-project-root))
              cmake-ide-build-dir   (expand-file-name build-dir
                                                      cmake-ide-project-dir)
              cmake-ide-cmake-opts  (concat "-DCMAKE_BUILD_TYPE="
                                            vs-cmake-build-type))
        (message "===> Cmake IDE: %s[%s] %s" cmake-ide-project-dir build-dir cmake-ide-cmake-opts))
      (vs|cmake-ide/prepare-symlink)))

  (advice-add 'cmake-ide-maybe-run-cmake :before 'vs|cmake-ide/before-maybe-run-cmake)

  :hook (c-initialization . cmake-ide-setup))


(use-package lsp-mode
  :after cmake-ide
  :config
  (setq lsp-eldoc-render-all          nil
        lsp-highlight-symbol-at-point nil
        lsp-inhibit-message           nil)

  (defun vs|lsp-mode/language-id (buffer)
    "Return language ID string accordingly to buffer's file name."
    (if (string-match "\\.\\([ch]\\(pp\\|xx\\|\\+\\+\\)\\)\\|\\(cc\\|hh\\)\\|\\(CC?\\|HH?\\)\\$"
                      (buffer-file-name buffer))
        "cpp"
      "c"))

  (defun vs|lsp-mode/clangd-options ()
    "Generate `clangd' options."
    (let ((clang-path (if running-on-macos
                          "/usr/local/opt/llvm/bin/clangd"
                        "clangd"))
          (clang-opts "-compile-commands-dir=%s"))
      (vs|emacs|apply-dir-locals)
      (list clang-path (format clang-opts
                               (expand-file-name vs-cmake-build-dir
                                                 (projectile-project-root))))))

  (lsp-define-stdio-client lsp-clangd
                           nil
                           'projectile-project-root
                           nil
                           :ignore-regexps '("^Error -[0-9]+: .+$")
                           :command-fn     'vs|lsp-mode/clangd-options
                           :language-id-fn 'vs|lsp-mode/language-id)

  :hook ((c-mode   . lsp-clangd-enable)
         (c++-mode . lsp-clangd-enable)))


(use-package lsp-html
  :after lsp-mode
  :hook (html-mode  . lsp-html-enable))


(use-package lsp-java
  :after lsp-mode
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
      (message "===> Java projects added:%s" projects)))
  (advice-add 'lsp-java-enable :before 'vs|lsp-java/before-enable)

  :hook (java-mode . lsp-java-enable))


(use-package lsp-python
  :after lsp-mode
  :hook (python-mode . lsp-python-enable))


(use-package lsp-ui
  :after lsp-mode
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
   [remap xref-find-references]  'lsp-ui-peek-find-references )

  :hook (lsp-mode . lsp-ui-mode))


(use-package company-lsp
  :after (company lsp-mode)
  :config
  (setq company-lsp-enable-snippet   t
        company-lsp-cache-candidates t)

  (defun vs|company-lsp/enable()
    (add-to-list 'company-backends 'company-lsp))

  :hook (lsp-mode . vs|company-lsp/enable))


(use-package modern-cpp-font-lock :delight
  :commands modern-c++-font-lock-mode
  :hook (c++-mode . modern-c++-font-lock-mode))


(provide 'use-lsp-mode)
;;; use-lsp-mode.el ends here
