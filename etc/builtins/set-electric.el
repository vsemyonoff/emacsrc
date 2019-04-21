;;; set-electric.el ---  electric pair mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)

;; Triggers
(add-hook 'vs-emacs-config-hook #'electric-pair-mode)

;; Config
(with-eval-after-load 'electric
  (setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit
        electric-pair-preserve-balance  nil)
  )

(provide 'set-electric)
;;; set-electric.el ends here
