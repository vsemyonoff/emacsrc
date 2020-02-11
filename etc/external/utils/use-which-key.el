;;; use-which-key.el --- show keybindings help. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'which-key))
    (warn "===> Can't install 'which-key'")

  (add-hook 'vs-emacs-config-hook 'which-key-mode)

  (with-eval-after-load 'which-key
    (setq which-key-popup-type      'minibuffer
          which-key-show-docstrings t
          )
    )
  )

(provide 'use-which-key)
;;; use-which-key.el ends here
