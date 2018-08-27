;;; use-solaire.el ---  fade out inactive windows. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package solaire-mode
  :config (if (or (daemonp) (not (display-graphic-p)))
              (add-hook 'after-make-frame-functions (lambda (&optional _) (solaire-mode-swap-bg)) t)
            (add-hook 'vs-config-hook #'solaire-mode-swap-bg t))
  :hook ((after-revert         . turn-on-solaire-mode      )
         (change-major-mode    . turn-on-solaire-mode      )
         (ediff-prepare-buffer . solaire-mode              )
         (minibuffer-setup     . solaire-mode-in-minibuffer))
  )

(provide 'use-solaire)
;;; use-solaire.el ends here
