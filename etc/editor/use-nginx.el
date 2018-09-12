;;; use-nginx.el ---  nginx mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package nginx-mode
  :mode ("\\.tpl\\'" . nginx-mode))


(use-package company-nginx
  :after (company nginx-mode)
  :hook (nginx-mode . company-nginx-keywords))


(provide 'use-nginx)
;;; use-nginx.el ends here
