;;; init.el --- Emacs configuration entry point. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
;;(package-initialize)

;; Unicode
(set-charset-priority                   'unicode)
(prefer-coding-system                   'utf-8  )
(set-keyboard-coding-system             'utf-8  )
(set-selection-coding-system            'utf-8  )
(set-terminal-coding-system             'utf-8  )
(setq-default buffer-file-coding-system 'utf-8  )

;; Constants
(defconst vs-xdg-dir (expand-file-name (or (getenv "XDG_HOME") "~/.local"))
  "`freedesktop.org' folder.")

(defconst vs-xdg-cache-dir (expand-file-name (or (getenv "XDG_CACHE_HOME") "~/.cache"))
  "`freedesktop.org' cache folder.")

(defconst vs-xdg-config-dir (expand-file-name (or (getenv "XDG_CONFIG_HOME") "~/.config"))
  "`freedesktop.org' config folder.")

(defconst vs-xdg-data-dir (expand-file-name (or (getenv "XDG_DATA_HOME")
                                                (expand-file-name "share" vs-xdg-dir)))
  "`freedesktop.org' data folder.")

(defconst vs-emacs-home-dir (file-name-directory (or load-file-name (buffer-file-name)))
  "Top-level Emacs folder.")

(defconst vs-emacs-cache-dir (expand-file-name "emacs" vs-xdg-cache-dir)
  "Emacs cache folder.")

(defconst vs-emacs-config-dir (expand-file-name "etc" vs-emacs-home-dir)
  "Emacs configs folder.")

(defconst vs-emacs-data-dir (expand-file-name "share" vs-emacs-home-dir)
  "Emacs data folder.")

(defconst vs-user-home-dir (expand-file-name "~")
  "User's home folder.")

;; Garbage collector defaults
(defconst gc-cons-percentage--default gc-cons-percentage
  "Default garbage collector percentage value.")

(defconst gc-cons-threshold--default gc-cons-threshold
  "Default garbage collector threshold value.")

;; Hook variables
(defvar vs-emacs-config-hook nil
  "Hook called after Emacs init and command line parsing is done.")

(defvar vs-emacs-config-gui-hook nil
  "Hook called after frame creation is done.")

(defvar vs-emacs-config-final-hook nil
  "Final hook called before configuration ends.")

(defvar vs-emacs-theme-enabled-hook nil
  "Hook called after Emacs theme is enabled.")
(advice-add 'enable-theme :after
            (lambda (&rest _)
              "Run `vs-emacs-theme-enabled-hook' hook."
              (run-hooks 'vs-emacs-theme-enabled-hook)))

(defvar vs-emacs-theme-loaded-hook nil
  "Hook called after Emacs theme is loaded.")
(advice-add 'load-theme :after
            (lambda (&rest _)
              "Run `vs-emacs-theme-loaded-hook' hook."
              (run-hooks 'vs-emacs-theme-loaded-hook)))

;; Create cache folder
(unless (file-exists-p vs-emacs-cache-dir)
  (make-directory vs-emacs-cache-dir t))

;; Load settings customized with UI
(setq custom-file (expand-file-name "custom.el" vs-emacs-cache-dir))
(load custom-file 'noerror)

;; Main stuff
(eval-and-compile
  (let ((gc-cons-percentage (* gc-cons-percentage--default 6.0))
        (gc-cons-threshold  most-positive-fixnum               ))

    (add-to-list 'load-path vs-emacs-config-dir)

    (require 'set-ostweaks)    ; linux/mac specific tweaks
    (require 'set-functions)   ; useful functions
    (require 'set-pkgmgr)      ; package manager settings
    (require 'set-utilities)   ; common utilities

    (unless noninteractive
      (require 'set-editor)    ; editor behavior
      (require 'set-interface) ; interface settings
      (require 'set-tools))))  ; browser/email/messengers settings

;; Editor config
(add-hook 'emacs-startup-hook (lambda () (run-hooks 'vs-emacs-config-hook)))

;; Delayed GUI config
(add-hook (if (daemonp) 'after-make-frame-functions 'window-setup-hook)
          (lambda (&optional frame)
            (when frame (select-frame-set-input-focus frame))
            (run-hooks 'vs-emacs-config-gui-hook)))

;; Final hook
(add-hook 'emacs-startup-hook (lambda () (run-hooks 'vs-emacs-config-final-hook)))
;;; init.el ends here