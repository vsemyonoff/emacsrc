;;; use-company.el ---  company mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package company
  :delight (company-mode " Ⓒ")
  :hook (vs-config . global-company-mode)
  )

;; (use-package company-quickhelp
;;   :after company
;;   :disabled
;;   :hook (vs-config . company-quickhelp-mode)
;;   )

(provide 'use-company)
;;; use-company.el ends here
