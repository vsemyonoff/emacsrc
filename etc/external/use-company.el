;;; use-company.el ---  company mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)
(require 'straight)
(require 'delight)

(if (not (straight-use-package 'company))
    (warn "===> Can't install 'company'")

  ;; Triggers
  (add-hook 'vs-emacs-config-hook  #'global-company-mode)

  ;; Delight
  (delight 'company-mode nil 'company)

  ;; Config
  (with-eval-after-load 'company
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
    )
  )

(provide 'use-company)
;;; use-company.el ends here
