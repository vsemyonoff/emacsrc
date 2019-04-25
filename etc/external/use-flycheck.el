;;; use-flycheck.el ---  flycheck mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'flycheck))
    (warn "===> Can't install 'flycheck'")

  ;; Triggers
  (add-hook 'prog-mode-hook #'flycheck-mode)

  ;; Keybindings
  (define-key (current-global-map) (kbd "C-<f11>") #'flycheck-list-errors)

  ;; Config
  (with-eval-after-load "flycheck"
    (warn "===> [TODO]: setup flycheck from LSP mode as global")
    (setq flycheck-emacs-lisp-load-path 'inherit)

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

  (if (not (straight-use-package 'flycheck-pos-tip))
      (warn "===> Can't install 'flycheck-pos-tip'")

    ;; Triggers
    (add-hook 'vs-emacs-config-gui-hook #'flycheck-pos-tip-mode)

    ;; Config
    (with-eval-after-load 'flycheck-pos-tip
      (setq flycheck-display-errors-delay 0.5
            flycheck-pos-tip-timeout      10
            )
      )
    )
  )

(with-eval-after-load 'pos-tip
  (setq pos-tip-internal-border-width 6
        pos-tip-border-width          1
        )
  )

(provide 'use-flycheck)
;;; use-flycheck.el ends here
