;;; use-pass.el ---  ZX2C4 Pass integration. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'password-store))
    (warn "===> Can't install 'password-store'")

  (if (not (straight-use-package 'pass))
      (warn "===> Can't install 'pass'")
    )

  (if (not (straight-use-package '(auth-password-store
                                   :host github
                                   :repo "DamienCassou/auth-password-store")))
      (warn "===> Can't install 'auth-password-store'")

    (add-hook 'vs-emacs-config-hook #'auth-source-pass-enable)

    (with-eval-after-load 'auth-source-pass
      (setq auth-source-pass-path (getenv "PASSWORD_STORE_DIR"))
      )
    )
  )

(provide 'use-pass)
;;; use-pass.el ends here
