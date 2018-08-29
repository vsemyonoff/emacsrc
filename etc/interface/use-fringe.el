;;; use-fringe.el ---  fringe settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package fringe :ensure nil
  :config (setq-default fringe-indicator-alist ; remove continuation arrow on right fringe
                        (delq (assq 'continuation fringe-indicator-alist)
                              fringe-indicator-alist))
  :hook ((minibuffer-setup . (lambda ()
                               (set-window-fringes (minibuffer-window) 0 0 nil)))
         (vs-emacs-config  . (lambda () (fringe-mode 4)))))

(provide 'use-fringe)
;;; use-fringe.el ends here
