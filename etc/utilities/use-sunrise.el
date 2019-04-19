;;; use-sunrise.el --- Sunrise commander settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)

(if (not (straight-use-package 'frame-cmds))
    (warn "===> Can't install 'frame-cmds'")
  (require 'frame-cmds)

  (if (not (straight-use-package 'sunrise-commander))
      (warn "===> Can't install 'sunrise-commander'")

    (with-eval-after-load 'sunrise-commander
      ;; disable mouse
      (setq sr-cursor-follows-mouse nil)
      (define-key sr-mode-map [mouse-1] nil)
      (define-key sr-mode-map [mouse-movement] nil)

      ;; ;;tweak faces for paths
      ;; (set-face-attribute 'sr-active-path-face nil
      ;;                     :background "black")
      ;; (set-face-attribute 'sr-passive-path-face nil
      ;;                     :background "black")

      ;;advise sunrise to save frame arrangement
      ;;requires frame-cmds package
      (defun vs|sunrise/save-frame ()
        "Save frame configuration and then maximise frame for sunrise commander."
        (save-frame-config)
        (maximize-frame)
        )
      (advice-add 'sunrise :before #'vs|sunrise/save-frame)

      (defun vs|sunrise/restore-frame ()
        "Restore frame configuration saved prior to launching sunrise commander."
        (interactive)
        (jump-to-frame-config-register)
        )
      (advice-add 'sr-quit :after #'vs|sunrise/restore-frame)
      )
    )
  )

(provide 'use-sunrise)
;;; use-sunrise.el ends here
