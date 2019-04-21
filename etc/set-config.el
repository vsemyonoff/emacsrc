;;; set-config.el --- setup basic config. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'xdg)

;; XDG
(defconst vs-xdg-dir (or (getenv "XDG_HOME") (directory-file-name (file-name-directory (xdg-data-home))))
  "`freedesktop.org' base folder.")

(defconst vs-xdg-cache-dir (xdg-cache-home)
  "`freedesktop.org' cache folder.")

(defconst vs-xdg-config-dir (xdg-config-home)
  "`freedesktop.org' config folder.")

(defconst vs-xdg-data-dir (expand-file-name "share" vs-xdg-dir)
  "`freedesktop.org' data folder.")

;; Emacs
(defconst vs-emacs-cache-dir (expand-file-name "emacs" vs-xdg-cache-dir)
  "Emacs cache folder.")

(defconst vs-emacs-config-dir (expand-file-name "etc" user-emacs-directory)
  "Emacs configs folder.")

(defconst vs-emacs-data-dir (expand-file-name "share" user-emacs-directory)
  "Emacs data folder.")

;; Misc
(defconst vs-user-home-dir (expand-file-name "~")
  "User's home folder.")

(defconst vs-gc-cons-threshold (* 1024 1024 8)
  "Default garbage collector threshold value.")

(defvar vs--file-name-handler-alist nil
  "Restore `file-name-handler-alist' value.")

;; Hook variables
(defvar vs-emacs-config-hook nil
  "Hook called after Emacs init and command line parsing is done.")

(defvar vs-emacs-config-gui-hook nil
  "Hook called after frame creation is done.")

;; Theme
;;(defvar vs-emacs-theme-package 'color-theme-sanityinc-tomorrow
(defvar vs-emacs-theme-package 'kaolin-themes
  "Package name containing `vs-emacs-theme'.
Used as fallback package for `vs-emacs-alt-theme'.
If not set then it means that selected theme is builtin.")

;;(defvar vs-emacs-theme 'sanityinc-tomorrow-night
(defvar vs-emacs-theme 'kaolin-galaxy
  "Theme name inside `vs-emacs-theme-package'.")

(provide 'set-config)
;;; set-config.el ends here
