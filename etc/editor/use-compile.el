;;; use-compile.el ---  compilation settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package compile
  :config
  (setq compilation-always-kill    t           ; kill compilation process before starting another
        compilation-ask-about-save nil         ; save all buffers on `compile'
        compilation-scroll-output 'first-error)

  (defun vs|colorize-compilation-buffer ()
    "Colorize a compilation mode buffer."
    (when (eq major-mode 'compilation-mode)
      (let ((inhibit-read-only t))
        (require 'ansi-color)
        (ansi-color-apply-on-region (point-min) (point-max)))))


  :hook (compilation-filter . vs|colorize-compilation-buffer)
  )

(provide 'use-compile)
;;; use-compile.el ends here
