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
(defconst vs-emacs-dir (file-name-directory (or load-file-name (buffer-file-name)))
  "Top-level Emacs folder.")

(defconst vs-config-dir (expand-file-name "etc" vs-emacs-dir)
  "Emacs configuration folder.")

(defconst vs-cache-dir (expand-file-name "emacs"
                                         (convert-standard-filename
                                          (or (getenv "XDG_CACHE_HOME")
                                              "~/.cache")))
  "Cache folder, following \"freedesktop\" specification.")

(defconst vs-data-dir (expand-file-name "emacs"
                                        (convert-standard-filename
                                         (or (getenv "XDG_DATA_HOME")
                                             "~/.local/share")))
  "Data folder, following \"freedesktop\" specification.")

(defconst user-config-dir (expand-file-name "emacs"
                                            (convert-standard-filename
                                             (or (getenv "XDG_CONFIG_HOME")
                                                 "~/.config")))
  "User configs folder, following \"freedesktop\" specification.")

(defconst user-home-dir (expand-file-name (convert-standard-filename "~/"))
  "User's home folder.")

(defvar vs-config-hook nil
  "Hook called after Emacs init and command line parsing is done.")

(defvar vs-config-ui-hook nil
  "Hook called after frame creation is done.")

;; Create cache folder
(unless (file-exists-p vs-cache-dir)
  (make-directory vs-cache-dir t))

;; Load settings customized with UI
(setq custom-file (expand-file-name "custom.el" vs-cache-dir))
(load custom-file 'noerror)

;; Main stuff
(eval-and-compile
  (let ((gc-cons-threshold most-positive-fixnum)
        (gc-cons-percentage 0.6))
    (add-to-list 'load-path vs-config-dir)

    (require 'set-functions)           ; useful functions
    (require 'set-pkgmgr)              ; package manager settings
    (require 'set-utilities)           ; common utilities
    (require 'set-ostweaks)            ; linux/mac specific tweaks

    (unless noninteractive
      (require 'set-editor)            ; editor behavior
      (require 'set-interface)         ; interface settings
      (require 'set-tools)             ; browser/email/messengers settings
      (vs//require-dir user-config-dir)))) ; private settings (passwords, accounts etc)

;; Apply hooks
(if (or (daemonp) (not (display-graphic-p)))
    (add-hook 'after-make-frame-functions (lambda (&optional _)
                                            (run-hooks 'vs-config-ui-hook)))
  (add-hook 'vs-config-hook (lambda ()
                           (run-hooks 'vs-config-ui-hook))))

(add-hook 'emacs-startup-hook (lambda () (run-hooks 'vs-config-hook)))
;;; init.el ends here
