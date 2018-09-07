;;; use-company.el ---  company mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package company :delight
  :commands global-company-mode

  :config
  (setq company-dabbrev-code-ignore-case    t
        company-dabbrev-ignore-case         t
        company-etags-ignore-case           t
        company-idle-delay                  0.1
        company-minimum-prefix-length       2
        company-require-match               nil
        company-tooltip-flip-when-above     t
        company-tooltip-minimum-width       50
        company-tooltip-align-annotations   t
        company-tooltip-margin              2  )

  :hook (vs-emacs-config . global-company-mode))


(provide 'use-company)
;;; use-company.el ends here
