;;; use-wcheck.el ---  wcheck mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'wcheck-mode))
    (warn "===> Can't install 'wcheck-mode'")

  ;; Triggers
  (autoload 'wcheck-mode "wcheck-mode" "Toggle wcheck-mode." t)
  (autoload 'wcheck-change-language "wcheck-mode" "Switch wcheck-mode languages." t)
  (autoload 'wcheck-actions "wcheck-mode" "Open actions menu." t)
  (autoload 'wcheck-jump-forward "wcheck-mode" "Move point forward to next marked text area." t)
  (autoload 'wcheck-jump-backward "wcheck-mode" "Move point backward to previous marked text area." t)
  (add-hook 'text-mode-hook #'wcheck-mode)
  )

(provide 'use-wcheck)
;;; use-wcheck.el ends here
