;;; set-fringe.el ---  fringe settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)

;; Defaults
(setq-default fringe-indicator-alist (delq
                                      (assq 'continuation fringe-indicator-alist)
                                      fringe-indicator-alist)
              fringes-outside-margins    t
              indicate-buffer-boundaries t
              indicate-empty-lines       t)

;; Triggers
(autoload 'fringe-mode "fringe")
(add-hook 'vs-emacs-config-gui-hook
          (lambda ()
            "Enable fringe, set sizes."
            (when (display-graphic-p)
              (fringe-mode '(nil . 0)))))

;; Config
(with-eval-after-load 'fringe
  (warn "===> TODO: show unsaved changes in fringe")
  (defun vs|emacs/fringe-minibuffer-disable ()
    "Disable fringes in `minibuffer' windows."
    (set-window-fringes (minibuffer-window) 0 0 nil))
  (add-hook 'minibuffer-setup-hook #'vs|emacs/fringe-minibuffer-disable))

(provide 'set-fringe)
;;; set-fringe.el ends here
