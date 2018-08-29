;;; use-windmove.el ---  windows navigation settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package windmove
  :commands windmove-default-keybindings
  :hook (vs-emacs-config . (lambda () (windmove-default-keybindings 'meta))))

(provide 'use-windmove)
;;; set-windmove.el ends here
