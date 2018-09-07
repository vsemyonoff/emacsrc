;;; use-vtl.el ---  Apache Velocity templates mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package vtl
  :load-path (lambda ()
               (expand-file-name "site-lisp"
                                 vs-emacs-data-dir))

  :mode ("\\.tpl\\'" . turn-on-vtl-mode))


(provide 'use-vtl)
;;; set-vtl.el ends here
