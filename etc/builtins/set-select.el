;;; set-select.el ---  selection setup. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(with-eval-after-load 'select
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)
        select-enable-clipboard t
        select-enable-primary t)
  )

(provide 'set-select)
;;; set-select.el ends here
