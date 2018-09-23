;;; use-delight.el --- "use-package" extension. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package delight
  :config
  (delight '((eldoc-mode            nil       eldoc     )
             (emacs-lisp-mode       "ELisp"   elisp-mode)
             (lisp-interaction-mode "<ELisp>" elisp-mode))))


(provide 'use-delight)
;;; use-delight.el ends here
