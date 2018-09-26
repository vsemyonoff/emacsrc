;;; lsp-cpp.el --- C/C++ support for lsp-mode -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'lsp-mode)
(require 'projectile)


(defvar lsp-cpp-regex
  "\\.\\([ch]\\(pp\\|xx\\|\\+\\+\\)\\)\\|\\(cc\\|hh\\)\\|\\(CC?\\|HH?\\)\\$"
  "C++ extensions regular expression.")


(defvar lsp-cpp-clangd-exe (if (eq system-type 'darwin)
                               "/usr/local/opt/llvm/bin/clangd"
                             "clangd")
  "The clangd executable.")


(defvar-local lsp-cpp-cdb-dir ""
  "Compilation data base file path, relative to the project root.")


(defun lsp-cpp//language-id (buffer)
  "Return language id string accordingly to BUFFER's file name extension."
  (if (string-match lsp-cpp-regex (buffer-file-name buffer))
      "cpp"
    "c"))


(defun lsp-cpp//clangd-options ()
  "Generate `clangd' options."
  (list lsp-cpp-clangd-exe (format "-compile-commands-dir=%s"
                                   (expand-file-name lsp-cpp-cdb-dir
                                                     (projectile-project-root)))))


(lsp-define-stdio-client lsp-cpp
                         nil
                         'projectile-project-root
                         nil
                         :ignore-regexps '("^Error -[0-9]+: .+$")
                         :command-fn     'lsp-cpp//clangd-options
                         :language-id-fn 'lsp-cpp//language-id)


(provide 'lsp-cpp)
;;; lsp-cpp.el ends here
