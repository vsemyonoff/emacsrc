;;; use-flycheck.el ---  flycheck mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package flycheck :delight
  :commands (flycheck-mode flycheck-list-errors flycheck-buffer)
  :config (setq flycheck-check-syntax-automatically '(save mode-enabled))
  :hook (emacs-lisp-mode . flycheck-mode))


(use-package flycheck-pos-tip
  :after flycheck
  :config
  (setq flycheck-display-errors-delay 0.5
        flycheck-pos-tip-timeout      10 )
  :hook (vs-emacs-config-gui . flycheck-pos-tip-mode))


(provide 'use-flycheck)
;;; use-flycheck.el ends here
