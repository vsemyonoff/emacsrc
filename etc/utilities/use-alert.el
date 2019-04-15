;;; use-alert.el --- notifications library. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)

(straight-use-package 'alert)

(with-eval-after-load 'alert
  (setq alert-default-style (if (display-graphic-p)
                                'notifications
                              'mode-line)))

(provide 'use-alert)
;;; use-alert.el ends here
