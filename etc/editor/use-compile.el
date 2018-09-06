;;; use-compile.el ---  compilation settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package compile
  :config
  (progn
    (setq compilation-always-kill    t           ; kill compilation process before starting another
          compilation-ask-about-save nil         ; save all buffers on `compile'
          compilation-scroll-output 'first-error)

    (defun vs|compile/colorize ()
      "Colorize a compilation mode buffer."
      (when (eq major-mode 'compilation-mode)
        (let ((inhibit-read-only t))
          (require 'ansi-color)
          (ansi-color-apply-on-region (point-min) (point-max))))))

  :hook (compilation-filter . vs|compile/colorize))

(provide 'use-compile)
;;; use-compile.el ends here
