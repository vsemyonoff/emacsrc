;;; set-treemacs-icons.el ---  treemacs icons settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;;    stolen from 'kaolin-theme'.
;;; Code:
(with-eval-after-load 'treemacs
  (with-eval-after-load 'all-the-icons
    (setq treemacs-icons-hash (make-hash-table :size 200 :test #'equal)
          treemacs-icon-fallback (format "%s " (all-the-icons-faicon "file-text-o"))
          treemacs-icon-text treemacs-icon-fallback)

    (setq treemacs-icon-root-png
          (format " %s " (all-the-icons-material "subject" :v-adjust -0.2 :height 1.4
                                                 :face 'font-lock-variable-name-face))

          treemacs-icon-open-png
          (format "%s " (all-the-icons-material "folder_open" :v-adjust -0.2 :height 1.15 'font-lock-doc-face))

          treemacs-icon-closed-png
          (format "%s " (all-the-icons-material "folder" :v-adjust -0.2 :height 1.15))

          treemacs-icon-tag-open-png
          (all-the-icons-faicon "chevron-down" :v-adjust 0.1)

          treemacs-icon-tag-closed-png
          (all-the-icons-faicon "location-arrow" :v-adjust 0.1)

          treemacs-icon-tag-node-open-png
          (format "%s " (all-the-icons-faicon "chevron-down"  :height 0.75 :face 'font-lock-keyword-face))

          treemacs-icon-tag-node-closed-png
          (format "%s " (all-the-icons-faicon "location-arrow" :height 0.9  :face 'font-lock-keyword-face))

          treemacs-icon-tag-leaf-png
          (format "%s " (all-the-icons-faicon "tag" :height 0.9 :face 'font-lock-type-face))
          )

    ;; Icons for filetypes
    (treemacs-define-custom-icon (all-the-icons-alltheicon "csharp-line") "cs")
    (treemacs-define-custom-icon (all-the-icons-alltheicon "css3") "css")
    (treemacs-define-custom-icon (all-the-icons-alltheicon "git") "gitignore")
    (treemacs-define-custom-icon (all-the-icons-alltheicon "html5") "html" "htm")
    (treemacs-define-custom-icon (all-the-icons-alltheicon "java") "java")
    (treemacs-define-custom-icon (all-the-icons-alltheicon "javascript-badge") "js")
    (treemacs-define-custom-icon (all-the-icons-alltheicon "python") "py")
    (treemacs-define-custom-icon (all-the-icons-alltheicon "rust") "rs")
    (treemacs-define-custom-icon (all-the-icons-alltheicon "haskell") "hs")
    (treemacs-define-custom-icon (all-the-icons-alltheicon "c") "c")
    (treemacs-define-custom-icon (all-the-icons-alltheicon "cplusplus") "cpp")
    (treemacs-define-custom-icon (all-the-icons-alltheicon "ruby-alt") "rb")
    (treemacs-define-custom-icon (all-the-icons-alltheicon "scala") "scala")
    (treemacs-define-custom-icon (all-the-icons-alltheicon "elixir") "ex" "exs")
    (treemacs-define-custom-icon (all-the-icons-alltheicon "erlang") "erl" "hrl")
    (treemacs-define-custom-icon (all-the-icons-alltheicon "clojure") "clj" "cljs")
    (treemacs-define-custom-icon (all-the-icons-fileicon "cabal") "cabal")
    (treemacs-define-custom-icon (all-the-icons-fileicon "clisp") "lisp")
    (treemacs-define-custom-icon (all-the-icons-fileicon "go") "go")
    (treemacs-define-custom-icon (all-the-icons-fileicon "elisp") "el" "elc")
    (treemacs-define-custom-icon (all-the-icons-fileicon "julia") "jl")
    (treemacs-define-custom-icon (all-the-icons-fileicon "kotlin") "kt" "kts")
    (treemacs-define-custom-icon (all-the-icons-fileicon "hy") "hy")
    (treemacs-define-custom-icon (all-the-icons-fileicon "jsx2-alt") "jsx")
    (treemacs-define-custom-icon (all-the-icons-fileicon "ocaml") "ml" "mli")
    (treemacs-define-custom-icon (all-the-icons-fileicon "org") "org")
    (treemacs-define-custom-icon (all-the-icons-fileicon "php") "php")
    (treemacs-define-custom-icon (all-the-icons-alltheicon "terminal") "sh" "zsh")
    (treemacs-define-custom-icon (all-the-icons-fileicon "typescript") "ts")
    (treemacs-define-custom-icon (all-the-icons-fileicon "nimrod") "nim" "nims")
    (treemacs-define-custom-icon (all-the-icons-fileicon "perl6") "pm6")
    (treemacs-define-custom-icon (all-the-icons-fileicon "tex") "tex")
    (treemacs-define-custom-icon (all-the-icons-fileicon "rst") "rst")
    (treemacs-define-custom-icon (all-the-icons-fileicon "vue") "vue")
    (treemacs-define-custom-icon (all-the-icons-octicon "markdown") "md" "markdown")
    (treemacs-define-custom-icon (all-the-icons-octicon "file-pdf") "pdf")
    (treemacs-define-custom-icon (all-the-icons-octicon "database") "sql")
    (treemacs-define-custom-icon (all-the-icons-material "style") "styles")

    (treemacs-define-custom-icon (all-the-icons-octicon "file-media")
                                 "jpg" "jpeg" "png" "gif" "ico" "tif" "tiff" "svg" "bmp"
                                 "psd" "ai" "eps" "indd" "mov" "avi" "mp4" "webm" "mkv"
                                 "wav" "mp3" "ogg" "midi")

    (treemacs-define-custom-icon (all-the-icons-faicon "file-text-o")
                                 "rst" "log" "txt" "CONTRIBUTE" "LICENSE" "README" "CHANGELOG")

    (treemacs-define-custom-icon (all-the-icons-faicon "cogs")
                                 "conf" "cfg" "yaml" "yml" "json" "xml" "toml" "cson" "ini")

    (treemacs-define-custom-icon (all-the-icons-octicon "code")
                                 "tpl" "erb" "mustache" "twig" "ejs" "mk" "haml" "pug" "jade")

    (treemacs-define-custom-icon (all-the-icons-octicon "file-zip")
                                 "zip" "xz" "tar" "7z" "rar")
    )
  )

(provide 'set-treemacs-icons)
;;; set-treemacs-icons.el ends here
