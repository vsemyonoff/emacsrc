;;; use-emacs.el ---  internal Emacs features settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package emacs
  :config
  (progn
    (advice-add 'display-startup-echo-area-message :override 'ignore)

    (setq-default bidi-display-reordering           nil
                  c-basic-offset                    4
                  cursor-in-non-selected-windows    nil
                  ;;debug-on-error                    t
                  display-line-numbers-width        3
                  fill-column                       120
                  indent-tabs-mode                  nil
                  require-final-newline             t
                  tab-width                         4
                  truncate-lines                    t  )

    (setq ad-redefinition-action                    'warn
          apropos-do-all                            t
          create-lockfiles                          nil
          enable-local-variables                    nil
          enable-recursive-minibuffers              nil
          history-length                            500
          inhibit-startup-echo-area-message         user-login-name
          inhibit-startup-message                   t
          initial-scratch-message                   nil
          load-prefer-newer                         t
          max-mini-window-height                    0.3
          minibuffer-prompt-properties              '(cursor-intangible t
                                                      face minibuffer-prompt
                                                      point-entered minibuffer-avoid-prompt
                                                      read-only t)
          mode-line-format                          nil
          resize-mini-windows                       'grow-only
          tab-always-indent                         t  )

    (fset 'yes-or-no-p        'y-or-n-p) ; y/n (or SPS/DEL) against yes/no

    (blink-cursor-mode               -1) ; cursor blinking
    (menu-bar-mode                   -1) ; menu bar
    (scroll-bar-mode                 -1) ; scroll bar
    (tool-bar-mode                   -1) ; tool bar
    (tooltip-mode                    -1) ; tool tops

    (column-number-mode              -1) ; column number in mode line
    (line-number-mode                -1) ; line numbers in mode line
    (size-indication-mode            -1) ; size indicator in mode line

    (electric-pair-mode               t) ; auto close parens
    (global-auto-revert-mode          t) ; revert file if changed externally
    (global-prettify-symbols-mode     t) ; replace some symbols with shortcuts

    ;; make a shell script executable automatically on save
    (add-hook 'after-save-hook
              'executable-make-buffer-file-executable-if-script-p)

    (defun vs|emacs/quit-window-kills-buffer (&optional kill window)
      "When running `quit-window' always kill underlying buffer."
      (list (if (delq (or window (selected-window))
                      (get-buffer-window-list nil nil t))
                nil
              t)
            window))
    (advice-add 'quit-window :filter-args 'vs|emacs/quit-window-kills-buffer)

    (defun vs|emacs/minibuffer-setup-gc ()
      (setq gc-cons-percentage (* gc-cons-percentage--default 6.0)
            gc-cons-threshold  most-positive-fixnum))

    (defun vs|emacs/minibuffer-reset-gc ()
      (setq gc-cons-percentage gc-cons-percentage--default
            gc-cons-threshold  gc-cons-threshold--default))

    (defun vs|emacs/enable-ui-keystrokes ()
      (setq echo-keystrokes 0.02))

    (defun vs|emacs/disable-ui-keystrokes ()
      (setq echo-keystrokes 0))

    (defun vs|emacs|smart-move-beginning-of-line (arg)
      "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
      (interactive "^p")
      (setq arg (or arg 1))

      ;; Move lines first
      (when (/= arg 1)
        (let ((line-move-visual nil))
          (forward-line (1- arg))))

      (let ((orig-point (point)))
        (back-to-indentation)
        (when (= orig-point (point))
          (move-beginning-of-line 1))))

    (defun vs|emacs|backward-delete-line ()
      (interactive)
      (delete-region (point)
                     (line-beginning-position)))

    (defun vs|emacs/kill-thing-at-point (thing)
      "Kill the `thing-at-point' for the specified kind of THING."
      (let ((bounds (bounds-of-thing-at-point thing)))
        (if bounds
            (kill-region (car bounds) (cdr bounds))
          (error "No %s at point" thing))))

    (defun vs|emacs|kill-word-at-point ()
      "Kill the word at point."
      (interactive)
      (vs|emacs/kill-thing-at-point 'word))

    (defun vs|emacs|delete-word (arg)
      "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
      (interactive "p")
      (delete-region (point) (progn (forward-word arg) (point))))

    (defun vs|emacs|backward-delete-word (arg)
      "Delete characters backward until encountering the end of a word.
With argument, do this that many times."
      (interactive "p")
      (vs|emacs|delete-word (- arg))))

  :general
  ([remap move-beginning-of-line] 'vs|emacs|smart-move-beginning-of-line
   "<A-backspace>"                '(vs|emacs|backward-delete-word :which-key
                                                                  "backward delete word")
   "<A-left>"                     'left-word
   "<A-right>"                    'right-word
   "<C-backspace>"                nil
   "<C-S-backspace>"              nil
   "<C-left>"                     'move-beginning-of-line
   "<C-right>"                    'move-end-of-line
   "<M-backspace>"                '(vs|emacs|backward-delete-line :which-key
                                                                  "backward delete line")
   "<M-f4>"                       'kill-this-buffer)

  :hook
  ((conf-mode        . display-line-numbers-mode      )
   (prog-mode        . display-line-numbers-mode      )
   (text-mode        . display-line-numbers-mode      )
   (isearch-mode     . vs|emacs/disable-ui-keystrokes )
   (isearch-mode-end . vs|emacs/enable-ui-keystrokes  )
   (minibuffer-setup . vs|emacs/minibuffer-setup-gc   )
   (minibuffer-exit  . vs|emacs/minibuffer-reset-gc   )
   (vs-emacs-config  . vs|emacs/enable-ui-keystrokes  ))

  :mode ("\\.h\\(h\\|pp\\|xx\\)\\'" . c++-mode))


(provide 'use-emacs)
;;; use-emacs.el ends here
