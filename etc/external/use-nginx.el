;;; use-nginx.el ---  nginx mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)

(straight-use-package 'nginx-mode)
;; Triggers
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . nginx-mode))

(straight-use-package 'company-nginx)
(with-eval-after-load 'company
  ;; Triggers
  (add-hook 'nginx-mode #'company-nginx-keywords))

(provide 'use-nginx)
;;; use-nginx.el ends here
