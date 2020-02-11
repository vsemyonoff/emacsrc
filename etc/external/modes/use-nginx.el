;;; use-nginx.el ---  nginx mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package nginx-mode
  :mode "\\.tpl\\'"
  )

(use-package company-nginx
  :after (company)
  :hook (nginx-mode . company-nginx-keywords)
  )

(provide 'use-nginx)
;;; use-nginx.el ends here
