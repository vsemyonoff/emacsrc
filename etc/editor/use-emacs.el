;;; use-emacs.el ---  internal Emacs features settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package emacs
  :config
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

  (defun vs|emacs/find-file-create-parents (filename &optional _)
    "Create parent directory if not exists while visiting file."
    (unless (file-exists-p filename)
      (let ((dir (file-name-directory filename)))
        (unless (file-exists-p dir)
          (make-directory dir t)))))
  (advice-add 'find-file :before 'vs|emacs/find-file-create-parents)

  (warn "===> TODO: protect visible buffers from kill")

  (defun vs|emacs/quit-window-kills-buffer (&optional kill window)
    "When running `quit-window' always kill underlying buffer."
    (list (if (delq (or window (selected-window))
                    (get-buffer-window-list nil nil t))
              nil
            t)
          window))
  (advice-add 'quit-window :filter-args 'vs|emacs/quit-window-kills-buffer)

  (defun vs|emacs/c-mode-setup ()
    "Common settings for C -based modes."
    (setq c-basic-offset 4))

  (defun vs|emacs/conf-mode-setup ()
    "Common settings for ALL programming modes."
    (display-line-numbers-mode t))

  (defun vs|emacs/prog-mode-setup ()
    "Common settings for ALL programming modes."
    (setq truncate-lines       t)
    (display-line-numbers-mode t))

  (defun vs|emacs/text-mode-setup ()
    "Common settings for ALL programming modes."
    (display-line-numbers-mode t))

  (defun vs|emacs/minibuffer-setup-gc ()
    "Increase `GC' percantage and threshold."
    (setq gc-cons-percentage (* gc-cons-percentage--default 6.0)
          gc-cons-threshold  most-positive-fixnum))

  (defun vs|emacs/minibuffer-reset-gc ()
    "Restore `GC' settings to default values."
    (setq gc-cons-percentage gc-cons-percentage--default
          gc-cons-threshold  gc-cons-threshold--default))

  :delight
  (eldoc-mode                    )
  (emacs-lisp-mode       "ELisp" )
  (lisp-interaction-mode "IELisp")

  :general
  ([remap move-beginning-of-line] 'vs|emacs|smart-move-beginning-of-line
   "<A-backspace>"                'vs|emacs|backward-delete-word
   "<A-left>"                     'left-word
   "<A-right>"                    'right-word
   "<C-S-backspace>"              nil
   "<C-backspace>"                nil
   "<C-left>"                     'move-beginning-of-line
   "<C-right>"                    'move-end-of-line
   "<M-backspace>"                'vs|emacs|backward-delete-line
   "<M-f4>"                       'kill-this-buffer)

  :hook
  ((c-mode-common    . vs|emacs/c-mode-setup       )
   (conf-mode        . vs|emacs/conf-mode-setup    )
   (minibuffer-exit  . vs|emacs/minibuffer-reset-gc)
   (minibuffer-setup . vs|emacs/minibuffer-setup-gc)
   (prog-mode        . vs|emacs/prog-mode-setup    )
   (text-mode        . vs|emacs/text-mode-setup    )))


(provide 'use-emacs)
;;; use-emacs.el ends here
