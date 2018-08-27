;;; use-emacs.el ---  internal Emacs features settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package emacs
  :config
  (setq-default bidi-display-reordering           nil
                cursor-in-non-selected-windows    nil
                display-line-numbers-width        3
                fill-column                       120
                indent-tabs-mode                  nil
                indicate-buffer-boundaries        t
                indicate-empty-lines              t
                require-final-newline             t
                tab-width                         4  )

  (setq ad-redefinition-action                    'warn
        apropos-do-all                            t
        create-lockfiles                          nil
        ;;display-line-numbers                      t
        enable-recursive-minibuffers              nil
        history-length                            500
        inhibit-startup-message                   t
        initial-scratch-message                   nil
        load-prefer-newer                         t
        max-mini-window-height                    0.3
        minibuffer-prompt-properties              '(read-only
                                                    t
                                                    point-entered
                                                    minibuffer-avoid-prompt
                                                    face
                                                    minibuffer-prompt)
        resize-mini-windows                       'grow-only
        tab-always-indent                         t  )

  (fset 'yes-or-no-p        'y-or-n-p) ; y/n (or SPS/DEL) against yes/no

  (blink-cursor-mode               -1) ; disable cursor blinking
  (menu-bar-mode                   -1) ; disable menu bar
  (scroll-bar-mode                 -1) ; disable scroll bar
  (tool-bar-mode                   -1) ; disable tool bar
  (tooltip-mode                    -1) ; disable tool tops

  (column-number-mode               t) ; show column number in mode line
  (line-number-mode                -1) ; disable line numbers in mode line
  (size-indication-mode             t) ; show size indicator in mode line

  (defun vs|minibuffer-setup-gc ()
    (setq gc-cons-percentage-save gc-cons-percentage
          gc-cons-threshold-save gc-cons-threshold
          gc-cons-percentage 0.6
          gc-cons-threshold most-positive-fixnum))

  (defun vs|minibuffer-reset-gc ()
    (setq gc-cons-percentage gc-cons-percentage-save
          gc-cons-threshold gc-cons-threshold-save))

  (defun vs|enable-ui-keystrokes ()
    (setq echo-keystrokes 0.02))

  (defun vs|disable-ui-keystrokes ()
    (setq echo-keystrokes 0))


  :hook ((conf-mode        . display-line-numbers-mode)
         (isearch-mode     . vs|disable-ui-keystrokes )
         (isearch-mode-end . vs|enable-ui-keystrokes  )
         (minibuffer-setup . vs|minibuffer-setup-gc   )
         (minibuffer-exit  . vs|minibuffer-reset-gc   )
         (prog-mode        . display-line-numbers-mode)
         (text-mode        . display-line-numbers-mode)
         (vs-config        . vs|enable-ui-keystrokes  ))
  )

(provide 'use-emacs)
;;; use-emacs.el ends here
