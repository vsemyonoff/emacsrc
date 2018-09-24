;;; set-editor.el --- editor settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(setq-default bidi-display-reordering        nil
              cursor-in-non-selected-windows nil
              display-line-numbers-width     4
              fill-column                    120
              indent-tabs-mode               nil
              mode-line-format               nil
              require-final-newline          t
              tab-width                      4)

(setq ad-redefinition-action                 'warn
      apropos-do-all                         t
      create-lockfiles                       nil
      ;;debug-on-error                         t
      echo-keystrokes                        0.02
      enable-dir-local-variables             nil
      ;;enable-local-variables                 nil
      enable-recursive-minibuffers           nil
      help-window-select                     t
      history-length                         500
      inhibit-startup-echo-area-message      user-login-name
      inhibit-startup-message                t
      initial-scratch-message                nil
      load-prefer-newer                      t
      minibuffer-prompt-properties           '(cursor-intangible t
                                               face minibuffer-prompt
                                               point-entered minibuffer-avoid-prompt
                                               read-only t)
      tab-always-indent                      'complete)

;; ediff - don't start another frame
(require 'ediff)
(setq ediff-split-window-function 'split-window-horizontally
      ediff-window-setup-function 'ediff-setup-windows-plain)

;; cleanup old buffers
(require 'midnight)
(midnight-mode t)

;; saner regex syntax
(require 're-builder)
(setq reb-re-syntax 'string)

(require 'eshell)
(setq eshell-directory-name (expand-file-name "eshell" vs-emacs-cache-dir))

(vs|emacs/require-dir (expand-file-name "editor" vs-emacs-config-dir))

(provide 'set-editor)
;;; set-editor.el ends here
