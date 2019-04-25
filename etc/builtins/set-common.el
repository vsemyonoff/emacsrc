;;; set-common.el ---  modes common settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;;     [TODO]: refactoring
;;; Code:
(defun vs|emacs/c-mode-setup ()
  "Common settings for C-based modes."
  (setq c-basic-offset 4)
  )

(defun vs|emacs/conf-mode-setup ()
  "Common settings for ALL config-based modes."
  (display-line-numbers-mode t)
  )

(defun vs|emacs/prog-mode-setup ()
  "Common settings for ALL programming modes."
  (setq truncate-lines       t)
  (display-line-numbers-mode t)
  )

(defun vs|emacs/text-mode-setup ()
  "Common settings for ALL text-based modes."
  (display-line-numbers-mode t)
  )

(add-hook 'c-mode-common-hook    #'vs|emacs/c-mode-setup)
(add-hook 'conf-mode-hook        #'vs|emacs/conf-mode-setup)
(add-hook 'prog-mode-hook        #'vs|emacs/prog-mode-setup)
(add-hook 'text-mode             #'vs|emacs/text-mode-setup)

(provide 'set-common)
;;; set-common.el ends here
