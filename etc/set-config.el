;;; set-config.el --- setup basic config. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; XDG dirs
(defconst vs-xdg-cache-dir (or (getenv "XDG_CACHE_HOME")
                               (expand-file-name "~/.cache"))
  "`freedesktop.org' cache folder."
  )

(defconst vs-xdg-config-dir (or (getenv "XDG_CONFIG_HOME")
                                (expand-file-name "~/.config"))
  "`freedesktop.org' config folder."
  )

(defconst vs-xdg-data-dir (or (getenv "XDG_DATA_HOME")
                              (expand-file-name "~/.local/share"))
  "`freedesktop.org' data folder."
  )

(defconst vs-xdg-runtime-dir (or (getenv "XDG_RUNTIME_DIR")
                                 (format "/run/user/%s"
                                         (user-real-uid)))
  "`freedesktop.org' runtime folder."
  )

(defconst vs-xdg-dir (directory-file-name
                      (file-name-directory
                       vs-xdg-data-dir))
  "`freedesktop.org' top-lovel folder."
)

;; Emacs dirs
(defconst vs-emacs-cache-dir (expand-file-name "emacs"
                                               vs-xdg-cache-dir)
  "Emacs cache folder."
  )

(defconst vs-emacs-config-dir (expand-file-name "etc"
                                                user-emacs-directory)
  "Emacs configs folder."
  )

(defconst vs-emacs-data-dir (expand-file-name "share"
                                              user-emacs-directory)
  "Emacs data folder."
  )

(defconst vs-emacs-runtime-dir (expand-file-name "emacs"
                                                 vs-xdg-runtime-dir)
  "Emacs runtime folder."
  )

;; Misc
(defconst vs-user-home-dir (expand-file-name "~")
  "User's home folder."
  )

(defvar vs-user-projects-dir (list "~/Sources")
  "User ptoject folders list."
  )

(defconst vs-gc-cons-threshold (* 1024 1024 16)
  "Default garbage collector threshold value."
  )

;; Hook variables
(defvar vs-emacs-config-hook nil
  "Normal hook run after Emacs init and command line parsing is done."
  )

(defvar vs-emacs-config-gui-hook nil
  "Normal hook run after frame creation is done."
  )

(defvar vs-emacs-theme-enabled-hook nil
  "Normal hook run after new theme was enabled."
  )

;; Theme
(defvar vs-emacs-theme-package 'color-theme-sanityinc-tomorrow
  "Package name containing `vs-emacs-theme'.
If not set then it means that selected theme is builtin."
  )

(defvar vs-emacs-theme 'sanityinc-tomorrow-eighties
  "Theme name inside `vs-emacs-theme-package'."
  )

;; Font
(defvar vs-emacs-fixed-font-family "Roboto Mono"
  "Default fixed font family."
  )

(defvar vs-emacs-variable-font-family "Roboto"
  "Default variable font family."
  )

;; Aspell settings
(defvar vs-emacs-aspell-bin (executable-find "aspell")
  "Spell checker program name."
  )

(defvar vs-aspell-dict-dir (expand-file-name "dict" vs-emacs-data-dir)
  "Local aspell dictionaries directory."
  )

(provide 'set-config)
;;; set-config.el ends here
