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
(defconst vs-xdg-cache-dir (expand-file-name (or (getenv "XDG_CACHE_HOME") "~/.cache"))
  "`freedesktop.org' cache folder.")

(defconst vs-xdg-config-dir (expand-file-name (or (getenv "XDG_CONFIG_HOME") "~/.config"))
  "`freedesktop.org' config folder.")

(defconst vs-xdg-data-dir (expand-file-name (or (getenv "XDG_DATA_HOME") "~/.local/share"))
  "`freedesktop.org' data folder.")

(defconst vs-xdg-local-dir (directory-file-name (file-name-directory vs-xdg-data-dir))
  "`freedesktop.org' local folder.")

(defconst vs-emacs-home-dir (file-name-directory (or load-file-name (buffer-file-name)))
  "Top-level Emacs folder.")

(defconst vs-emacs-cache-dir (expand-file-name "emacs" vs-xdg-cache-dir)
  "Emacs cache folder.")

(defconst vs-emacs-config-dir (expand-file-name "etc" vs-emacs-home-dir)
  "Emacs configs folder.")

(defconst vs-emacs-data-dir (expand-file-name "emacs" vs-xdg-data-dir)
  "Emacs data folder.")

(defconst vs-user-config-dir (expand-file-name "emacs" vs-xdg-config-dir)
  "User configs folder.")

(defconst vs-user-home-dir (expand-file-name "~")
  "User's home folder.")

;; Hook variables
(defvar vs-emacs-config-hook nil
  "Hook called after Emacs init and command line parsing is done.")

(defvar vs-emacs-config-gui-hook nil
  "Hook called after frame creation is done.")

(defvar vs-emacs-config-finish-hook nil
  "Final hook called before configuration ends.")

;; Create cache folder
(unless (file-exists-p vs-emacs-cache-dir)
  (make-directory vs-emacs-cache-dir t))

;; Load settings customized with UI
(setq custom-file (expand-file-name "custom.el" vs-emacs-cache-dir))
(load custom-file 'noerror)

;; Main stuff
(eval-and-compile
  (let ((gc-cons-threshold   most-positive-fixnum    )
        (gc-cons-percentage  (* gc-cons-percentage 6)))

    (add-to-list 'load-path vs-emacs-config-dir)

    (require 'set-ostweaks)    ; linux/mac specific tweaks
    (require 'set-functions)   ; useful functions
    (require 'set-pkgmgr)      ; package manager settings
    (require 'set-utilities)   ; common utilities

    (unless noninteractive
      (require 'set-editor)    ; editor behavior
      (require 'set-interface) ; interface settings
      (require 'set-tools)     ; browser/email/messengers settings
      (vs|emacs/require-dir
       vs-user-config-dir))))  ; private settings (passwords, accounts etc)

;; Editor config
(add-hook 'emacs-startup-hook (lambda () (run-hooks 'vs-emacs-config-hook)))

;; Delayed GUI config
(add-hook (if (daemonp) 'after-make-frame-functions
            'window-setup-hook)
          (lambda (&optional frame)
            (when frame (select-frame frame))
            (run-hooks 'vs-emacs-config-gui-hook)))

;; Final hook
(add-hook 'emacs-startup-hook (lambda () (run-hooks 'vs-emacs-config-final-hook)))

;;; init.el ends here
