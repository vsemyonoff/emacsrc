;;; use-delight.el --- "use-package" extension. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package delight
  :config (delight '((eldoc-mode            nil  eldoc )
                     (emacs-lisp-mode       "Ⓔ" :major)
                     (lisp-interaction-mode "Ⓔ" :major))))

(provide 'use-delight)
;;; use-delight.el ends here
