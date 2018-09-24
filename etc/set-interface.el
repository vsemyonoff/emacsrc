;;; set-interface.el --- interface settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(setq frame-inhibit-implied-resize  t
      highlight-nonselected-windows nil
      inhibit-default-init          t     ; do not load default faces library
      mode-line-default-help-echo   nil   ; disable mode-line mouseovers
      mouse-yank-at-point           t     ; middle-click paste at point, not at click
      ring-bell-function            'ignore
      show-help-function            nil   ; hide :help-echo text
      split-width-threshold         160   ; favor horizontal splits
      use-dialog-box                nil   ; always avoid GUI
      visible-bell                  nil
      visible-cursor                nil
      x-stretch-cursor              nil)

(use-package pos-tip
  :config (setq pos-tip-internal-border-width 6
                pos-tip-border-width          1))

(vs|emacs/require-dir (expand-file-name "interface" vs-emacs-config-dir))

(provide 'set-interface)
;;; set-interface.el ends here
