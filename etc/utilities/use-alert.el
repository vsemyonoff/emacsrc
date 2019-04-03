;;; use-alert.el --- notifications library. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package alert
  :commands alert
  :config
  (setq alert-default-style (if (display-graphic-p)
                                'notifications
                              'mode-line)))


(provide 'use-alert)
;;; use-alert.el ends here
