;;; use-fringe.el ---  fringe settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package fringe :ensure nil
  :commands fringe-mode
  :hook ((vs-emacs-config  . (lambda () (fringe-mode '(nil . 0))))
         (minibuffer-setup . (lambda () (set-window-fringes (minibuffer-window) 0 0 nil))))
  :init (setq-default indicate-buffer-boundaries t
                      indicate-empty-lines       t
                      fringe-indicator-alist     (delq (assq 'continuation fringe-indicator-alist)
                                                       fringe-indicator-alist)))

(provide 'use-fringe)
;;; use-fringe.el ends here
