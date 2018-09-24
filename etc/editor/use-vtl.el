;;; use-vtl.el ---  Apache Velocity templates mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package vtl
  :after nginx-mode
  :hook (nginx-mode . turn-on-vtl-mode)
  :load-path (lambda () (expand-file-name "site-lisp" vs-emacs-data-dir)))


(provide 'use-vtl)
;;; use-vtl.el ends here
