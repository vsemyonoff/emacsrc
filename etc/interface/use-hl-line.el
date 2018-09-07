;;; use-hl-line.el ---  highlight current line. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package hl-line
  :config
  (progn
    (setq hl-line-range-function 'vs|hl-line/range
          hl-line-sticky-flag    nil)

    (defun vs|hl-line/range ()
      (save-excursion
        (cons (progn (vertical-motion 0) (point))
              (progn (vertical-motion 1) (+ (point) 0))))))

  :hook ((conf-mode prog-mode text-mode) . hl-line-mode))


(provide 'use-hl-line)
;;; use-hl-line.el ends here
