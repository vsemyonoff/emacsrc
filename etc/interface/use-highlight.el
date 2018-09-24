;;; use-highlight.el ---  highlight minor modes. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package hl-line
  :config
  (setq hl-line-range-function 'vs|hl-line/range
        hl-line-sticky-flag    nil)

  (defun vs|hl-line/range ()
    (save-excursion
      (cons (progn (vertical-motion 0) (point))
            (progn (vertical-motion 1) (+ (point) 0)))))

  :hook ((conf-mode prog-mode text-mode) . hl-line-mode))


(use-package highlight-escape-sequences
  :commands hes-mode
  :hook ((conf-mode prog-mode) . hes-mode))


(use-package highlight-numbers
  :commands highlight-numbers-mode
  :hook ((conf-mode prog-mode) . highlight-numbers-mode))


(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


(use-package rainbow-mode
  :hook (css-mode conf-mode emacs-lisp-mode))


(provide 'use-highlight)
;;; use-highlight.el ends here
