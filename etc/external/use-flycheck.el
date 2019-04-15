;;; use-flycheck.el ---  flycheck mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)

(straight-use-package 'flycheck)
;; Triggers
(add-hook 'c-mode-common-hook   #'flycheck-mode)
(add-hook 'emacs-lisp-mode-hook #'flycheck-mode)
;; Keybindings
(define-key (current-global-map) (kbd "C-<f11>") #'flycheck-list-errors)
;; Config `flycheck'
(with-eval-after-load "flycheck"
  (warn "===> TODO: setup flycheck from LSP mode as global")
  (setq flycheck-emacs-lisp-load-path 'inherit))

(straight-use-package 'flycheck-pos-tip)
;; Triggers
(add-hook 'vs-emacs-config-gui-hook #'flycheck-pos-tip-mode)
;; Config
(with-eval-after-load 'pos-tip
  (setq pos-tip-internal-border-width 6
        pos-tip-border-width          1))
(with-eval-after-load 'flycheck-pos-tip
  (setq flycheck-display-errors-delay 0.5
        flycheck-pos-tip-timeout      10 ))

(provide 'use-flycheck)
;;; use-flycheck.el ends here
