;;; use-fringe.el ---  fringe settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package fringe :ensure nil
  :commands fringe-mode
  :config (warn "===> TODO: show unsaved changes in fringe")
  :hook
  ((vs-emacs-config  . (lambda ()
                         "Set defautl fringes size."
                         (fringe-mode '(nil . 0))))
   (minibuffer-setup . (lambda ()
                         "Disable fringes in `minibuffer' window."
                         (set-window-fringes (minibuffer-window) 0 0 nil))))

  :init
  (setq-default fringe-indicator-alist     (delq (assq 'continuation fringe-indicator-alist)
                                                 fringe-indicator-alist)
                fringes-outside-margins    t
                indicate-buffer-boundaries t
                indicate-empty-lines       t))


(use-package fringe-helper
  :commands (fringe-helper-define fringe-helper-convert)
  :init
  (unless (fboundp 'define-fringe-bitmap)
    (defun define-fringe-bitmap (&rest _))))


(provide 'use-fringe)
;;; use-fringe.el ends here
