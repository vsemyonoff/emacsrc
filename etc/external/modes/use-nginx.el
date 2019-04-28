;;; use-nginx.el ---  nginx mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'nginx-mode))
    (warn "===> Can't install 'nginx-mode'")

  ;; Triggers
  (add-to-list 'auto-mode-alist '("\\.tpl\\'" . nginx-mode))
  )

(with-eval-after-load 'company
  (if (not (straight-use-package 'company-nginx))
      (warn "===> Can't install 'company-nginx'")

    ;; Triggers
    (add-hook 'nginx-mode #'company-nginx-keywords)
    )
  )

(provide 'use-nginx)
;;; use-nginx.el ends here
