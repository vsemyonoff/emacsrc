;;; use-hl-line.el ---  highlight current line. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package hl-line
  :hook (vs-config . global-hl-line-mode)
  ;; :hook ((prog-mode text-mode conf-mode) . hl-line-mode)
  :config
  (setq hl-line-sticky-flag nil
        global-hl-line-sticky-flag nil)

  (when (boundp 'display-line-numbers)
    (defun vs//hl-line-range ()
      (cons (line-beginning-position)
            (cond ((save-excursion
                     (goto-char (line-end-position))
                     (and (eobp) (not (bolp))))
                   (1- (line-end-position)))
                  ((or (eobp) (save-excursion (forward-line) (eobp)))
                   (line-end-position))
                  (t
                   (line-beginning-position 2)))))
    (setq hl-line-range-function #'vs//hl-line-range))
  )

(provide 'use-hl-line)
;;; use-hl-line.el ends here
