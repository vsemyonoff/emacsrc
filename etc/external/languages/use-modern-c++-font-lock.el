;;; use-modern-c++-font-lock.el ---  C++ syntax settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'straight)
(require 'delight)

(if (not (straight-use-package 'modern-cpp-font-lock))
    (warn "===> Can't install 'modern-cpp-font-lock'")

  ;; Triggers
  (add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)

  ;; Config
  (with-eval-after-load 'modern-c++-font-lock
    (delight 'modern-c++-font-lock-mode nil 'modern-cpp-font-lock)
    )
  )

(provide 'use-modern-c++-font-lock)
;;; use-modern-c++-font-lock.el ends here
