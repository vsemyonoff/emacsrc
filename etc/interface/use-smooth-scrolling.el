;;; use-smooth-scrolling.el ---  fix scrolling. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package smooth-scrolling
  :config (setq mouse-wheel-progressive-speed nil
                mouse-wheel-scroll-amount     '(1 ((shift) . 1) ((control) . nil))
                smooth-scroll-margin          2  )
  :hook (vs-emacs-config . smooth-scrolling-mode))

(provide 'use-smooth-scrolling)
;;; use-smooth-scrolling.el ends here
