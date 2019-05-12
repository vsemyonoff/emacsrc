;;; set-paren.el ---  show paren mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(add-hook 'vs-emacs-config-hook #'show-paren-mode)

(with-eval-after-load 'paren
  (setq blink-matching-paren               t
        show-paren-delay                   0.05
        show-paren-highlight-openparen     t
        show-paren-when-point-in-periphery t
        show-paren-when-point-inside-paren t
        )

  (defun vs|paren|match-paren (arg)
    "Go to the matching paren if on a paren; otherwise insert %."
    (interactive "p")
    (cond ((looking-at "\\s(") (forward-list 1) (backward-char 1))
          ((looking-at "\\s)") (forward-char 1) (backward-list 1))
          (t (self-insert-command (or arg 1)))
          )
    )
  (global-set-key "%" #'vs|paren|match-paren)
  )

(provide 'set-paren)
;;; set-paren.el ends here
