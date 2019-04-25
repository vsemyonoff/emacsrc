;;; set-electric.el ---  electric pair mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(add-hook 'vs-emacs-config-hook #'electric-pair-mode)

(with-eval-after-load 'electric
  (setq electric-pair-delete-adjacent-pairs nil
        electric-pair-inhibit-predicate     'electric-pair-conservative-inhibit
        )
  )

(provide 'set-electric)
;;; set-electric.el ends here
