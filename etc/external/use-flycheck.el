;;; use-flycheck.el ---  flycheck mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package flycheck
  :hook (prog-mode . flycheck-mode)
  :bind ("C-<f11>" . flycheck-list-errors)
  :config
  (warn "===> [TODO]: setup flycheck from LSP mode as global")
  (setq flycheck-emacs-lisp-load-path 'inherit)

  (defun flycheck-display-error-messages-unless-error-buffer (errors)
    (unless (get-buffer-window flycheck-error-list-buffer)
      (flycheck-display-error-messages errors)))
  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-buffer)

  (define-fringe-bitmap 'flycheck-fringe-bitmap-ball
    (vector #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00111000
            #b01111100
            #b11111110
            #b11111110
            #b01111100
            #b00111000
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            )
    )

  (flycheck-define-error-level 'info
    :severity 0
    :compilation-level 2
    :overlay-category 'flycheck-info-overlay
    :fringe-bitmap 'flycheck-fringe-bitmap-ball
    :fringe-face 'flycheck-fringe-info
    :error-list-face 'flycheck-error-list-info
    )

  (flycheck-define-error-level 'warning
    :severity 1
    :compilation-level 2
    :overlay-category 'flycheck-warning-overlay
    :fringe-bitmap 'flycheck-fringe-bitmap-ball
    :fringe-face 'flycheck-fringe-warning
    :error-list-face 'flycheck-error-list-warning
    )

  (flycheck-define-error-level 'error
    :severity 2
    :compilation-level 2
    :overlay-category 'flycheck-error-overlay
    :fringe-bitmap 'flycheck-fringe-bitmap-ball
    :fringe-face 'flycheck-fringe-error
    :error-list-face 'flycheck-error-list-error
    )
  )

(provide 'use-flycheck)
;;; use-flycheck.el ends here
