;;; use-smooth-scrolling.el ---  fix scrolling. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)
(require 'straight)

(straight-use-package 'smooth-scrolling)

;; Triggers
(add-hook 'vs-emacs-config-hook #'smooth-scrolling-mode)

;; Config
(with-eval-after-load 'smooth-scrolling
  (setq mouse-wheel-progressive-speed nil
        mouse-wheel-scroll-amount     '(1 ((shift) . 1) ((control) . nil))
        smooth-scroll-margin          2  ))

(provide 'use-smooth-scrolling)
;;; use-smooth-scrolling.el ends here
