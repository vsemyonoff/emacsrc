;;; set-ostweaks.el --- linux/mac specific tweaks. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(defconst running-on-macos (eq system-type 'darwin))
(defconst running-on-linux (eq system-type 'gnu/linux))

(cond (running-on-macos
       (add-to-list 'default-frame-alist      '(fullscreen . fullboth)                 )
       (add-to-list 'exec-path                "/usr/local/bin"                         )
       (add-to-list 'exec-path                (expand-file-name ".bin" vs-user-home-dir))

       (setq mac-command-modifier             'meta
             mac-option-modifier              'alt
             mac-mouse-wheel-smooth-scroll    nil
             mac-redisplay-dont-reset-vscroll t
             ns-pop-up-frames                 nil))

      (running-on-linux
       (setq x-gtk-use-system-tooltips nil)))

(vs//require-dir (expand-file-name "ostweaks" vs-emacs-config-dir))

(provide 'set-ostweaks)
;;; set-ostweakss.el ends here
