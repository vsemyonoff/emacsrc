;;; use-highlight.el ---  highlight minor modes. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)
(require 'delight)

(if (not (straight-use-package 'highlight-escape-sequences))
    (warn "===> Can't install 'highlight-escape-sequences'")

  ;; Triggers
  (add-hook 'conf-mode-hook #'hes-mode)
  (add-hook 'prog-mode-hook #'hes-mode)
  )

(if (not (straight-use-package 'highlight-numbers))
    (warn "===> Can't install 'highlight-numbers'")

  ;; Triggers
  (add-hook 'conf-mode-hook #'highlight-numbers-mode)
  (add-hook 'prog-mode-hook #'highlight-numbers-mode)
  )

(if (not (straight-use-package 'rainbow-delimiters))
    (warn "===> Can't install 'rainbow-delimiters'")

  ;; Triggers
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )

(if (not (straight-use-package 'rainbow-mode))
    (warn "===> Can't install 'rainbow-mode'")

  ;; Triggers
  (add-hook 'css-mode-hook        #'rainbow-mode)
  (add-hook 'conf-mode-hook       #'rainbow-mode)
  (add-hook 'emacs-lisp-mode-hook #'rainbow-mode)

  ;; Delight
  (delight 'rainbow-mode nil 'rainbow-mode)
  )

(provide 'use-highlight)
;;; use-highlight.el ends here
