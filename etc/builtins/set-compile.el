;;; set-compile.el ---  compilation settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(with-eval-after-load 'compile
  (setq compilation-always-kill    t
        compilation-ask-about-save nil
        compilation-scroll-output 'first-error)

  (defun vs|compile/colorize ()
    "Colorize a compilation mode buffer."
    (when (eq major-mode 'compilation-mode)
      (let ((inhibit-read-only t))
        (require 'ansi-color)
        (ansi-color-apply-on-region (point-min) (point-max)))))

  (add-hook 'compilation-filter-hook #'vs|compile/colorize))

(provide 'set-compile)
;;; set-compile.el ends here
