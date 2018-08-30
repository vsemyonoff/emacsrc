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
(defconst vs-emacs-home-dir (file-name-directory (or load-file-name (buffer-file-name)))
  "Top-level Emacs folder.")

(defconst vs-emacs-config-dir (expand-file-name "etc" vs-emacs-home-dir)
  "Emacs configuration folder.")

(defconst vs-emacs-cache-dir (expand-file-name "emacs"
                                               (convert-standard-filename
                                                (or (getenv "XDG_CACHE_HOME")
                                                    "~/.cache")))
  "Cache folder, following `Freedesktop.org' specification.")

(defconst vs-emacs-data-dir (expand-file-name "emacs"
                                              (convert-standard-filename
                                               (or (getenv "XDG_DATA_HOME")
                                                   "~/.local/share")))
  "Data folder, following `Freedesktop.org' specification.")

(defconst vs-user-config-dir (expand-file-name "emacs"
                                               (convert-standard-filename
                                                (or (getenv "XDG_CONFIG_HOME")
                                                    "~/.config")))
  "User configs folder, following `Freedesktop.org' specification.")

(defconst vs-user-home-dir (expand-file-name (convert-standard-filename "~/"))
  "User's home folder.")

(defvar vs-emacs-config-hook nil
  "Hook called after Emacs init and command line parsing is done.")

(defvar vs-emacs-config-gui-hook nil
  "Hook called after frame creation is done.")

;; Create cache folder
(unless (file-exists-p vs-emacs-cache-dir)
  (make-directory vs-emacs-cache-dir t))

;; Load settings customized with UI
(setq custom-file (expand-file-name "custom.el" vs-emacs-cache-dir))
(load custom-file 'noerror)

;; Main stuff
(eval-and-compile
  (let ((gc-cons-threshold most-positive-fixnum)
        (gc-cons-percentage 0.6))
    (add-to-list 'load-path vs-emacs-config-dir)

    (require 'set-functions)           ; useful functions
    (require 'set-pkgmgr)              ; package manager settings
    (require 'set-utilities)           ; common utilities
    (require 'set-ostweaks)            ; linux/mac specific tweaks

    (unless noninteractive
      (require 'set-editor)            ; editor behavior
      (require 'set-interface)         ; interface settings
      (require 'set-tools)             ; browser/email/messengers settings
      (vs//require-dir vs-user-config-dir)))) ; private settings (passwords, accounts etc)

;; Apply hooks
(if (daemonp)
    (add-hook 'after-make-frame-functions (lambda (&optional frame)
                                            (select-frame frame)
                                            (run-hooks 'vs-emacs-config-gui-hook)))
  (add-hook 'vs-emacs-config-hook (lambda ()
                                    (run-hooks 'vs-emacs-config-gui-hook))))

(add-hook 'emacs-startup-hook (lambda () (run-hooks 'vs-emacs-config-hook)))
;;; init.el ends here
