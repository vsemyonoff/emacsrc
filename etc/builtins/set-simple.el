;;; set-simple.el --- basic settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)

(defun vs|emacs/simple-settings ()
  "Basic editing settings."
  (fset 'yes-or-no-p     'y-or-n-p) ; y/n (or SPS/DEL) against yes/no

  (blink-cursor-mode            -1) ; cursor blinking
  (menu-bar-mode                -1) ; menu bar
  (scroll-bar-mode              -1) ; scroll bar
  (tool-bar-mode                -1) ; tool bar
  (tooltip-mode                 -1) ; tool tops

  (column-number-mode           -1) ; column number in mode line
  (line-number-mode             -1) ; line numbers in mode line
  (size-indication-mode         -1) ; size indicator in mode line

  (electric-pair-mode           t ) ; auto close parens
  (global-prettify-symbols-mode t )); replace some symbols with shortcuts

(add-hook 'vs-emacs-config-hook #'vs|emacs/simple-settings)

(provide 'set-simple)
;;; set-simple.el ends here
