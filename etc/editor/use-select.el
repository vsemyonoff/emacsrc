;;; use-select.el ---  selection setup. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package select
  :config
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)
        select-enable-clipboard t
        select-enable-primary t))


(provide 'use-select)
;;; use-select.el ends here
