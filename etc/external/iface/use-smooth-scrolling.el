;;; use-smooth-scrolling.el ---  fix scrolling. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package smooth-scrolling
  :disabled
  :hook (vs-emacs-config . smooth-scrolling-mode)
  :config
  (setq mouse-wheel-progressive-speed nil
        mouse-wheel-scroll-amount     '(1 ((shift) . 1) ((control) . nil))
        smooth-scroll-margin          1
        )
  )

(provide 'use-smooth-scrolling)
;;; use-smooth-scrolling.el ends here
