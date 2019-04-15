;;; use-emacs.el ---  internal Emacs features settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
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

(define-key (current-global-map) [remap move-beginning-of-line] #'vs|emacs|smart-move-beginning-of-line)
(define-key (current-global-map) (kbd "A-<backspace>")          #'vs|emacs|backward-delete-word)
                                        ;"<A-left>"                     'left-word
                                        ;"<A-right>"                    'right-word
                                        ;"<C-S-backspace>"              nil
                                        ;"<C-backspace>"                nil
                                        ;"<C-left>"                     'move-beginning-of-line
                                        ;"<C-right>"                    'move-end-of-line
                                        ;"<M-backspace>"                'vs|emacs|backward-delete-line
                                        ;"<M-f4>"                       'kill-this-buffer)

(add-hook 'c-mode-common-hook    #'vs|emacs/c-mode-setup)
(add-hook 'conf-mode-hook        #'vs|emacs/conf-mode-setup)
(add-hook 'minibuffer-exit-hook  #'vs|emacs/disable-startup-optimizations)
(add-hook 'minibuffer-setup-hook #'vs|emacs/enable-startup-optimizations)
(add-hook 'prog-mode-hook        #'vs|emacs/prog-mode-setup)
(add-hook 'text-mode             #'vs|emacs/text-mode-setup)

(provide 'use-emacs)
;;; use-emacs.el ends here
