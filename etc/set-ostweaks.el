;;; set-ostweaks.el --- linux/mac specific tweaks. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(defconst running-on-linux (eq system-type 'gnu/linux))

(cond (running-on-linux
       ;; Disable GTK+ native tooltips
       (setq x-gtk-use-system-tooltips nil)))

(provide 'set-ostweaks)
;;; set-ostweaks.el ends here
