;;; set-builtins.el --- Emacs built-in packages settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; Unicode
(set-charset-priority 'unicode)

;; Create cache folder
(unless (file-exists-p vs-emacs-cache-dir)
  (make-directory vs-emacs-cache-dir t)
  )

;; Buffer local variables
(setq-default bidi-display-reordering        nil
              buffer-file-coding-system      'utf-8
              cursor-in-non-selected-windows nil
              display-line-numbers-width     4
              fill-column                    120
              indent-tabs-mode               nil
              mode-line-format               nil
              require-final-newline          t
              tab-width                      4
              )

;; Global variables
(setq ad-redefinition-action                 'accept
      apropos-do-all                         t
      auto-window-vscroll                    nil
      create-lockfiles                       nil
      custom-file                            (vs|emacs/config "set-custom.el")
      debug-on-error                         t
      echo-keystrokes                        0.02
      enable-dir-local-variables             nil
      help-window-select                     t
      history-length                         500
      inhibit-startup-echo-area-message      user-login-name
      inhibit-startup-message                t
      initial-scratch-message                nil
      load-prefer-newer                      noninteractive
      tab-always-indent                      t
      )

;; Look and feel
(setq frame-inhibit-implied-resize           t
      highlight-nonselected-windows          nil
      inhibit-default-init                   t     ; do not load default faces library
      mode-line-default-help-echo            nil   ; disable mode-line mouseovers
      mouse-yank-at-point                    t     ; middle-click paste at point, not at click
      ;;next-line-add-newlines                 t
      ring-bell-function                     'ignore
      scroll-conservatively                  10000
      scroll-margin                          0
      scroll-preserve-screen-position        t
      scroll-step                            1
      show-help-function                     nil   ; hide :help-echo text
      split-width-threshold                  160   ; favor horizontal splits
      use-dialog-box                         nil   ; always avoid GUI
      visible-bell                           nil
      visible-cursor                         nil
      x-gtk-use-system-tooltips              nil
      x-stretch-cursor                       nil
      )

;; Load settings customized with UI
(load custom-file 'noerror)

;; Other packages
(vs|emacs/require-dir (vs|emacs/config "builtins"))

(provide 'set-builtins)
;;; set-builtins.el ends here
