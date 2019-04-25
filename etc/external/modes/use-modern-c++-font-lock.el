;;; use-modern-c++-font-lock.el ---  C++ syntax settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'modern-cpp-font-lock))
    (warn "===> Can't install 'modern-cpp-font-lock'")

  ;; Triggers
  (add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)
  )

(provide 'use-modern-c++-font-lock)
;;; use-modern-c++-font-lock.el ends here
