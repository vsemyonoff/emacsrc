;;; set-ostweaks.el --- linux/mac specific tweaks. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(defconst running-on-macos (eq system-type 'darwin))
(defconst running-on-linux (eq system-type 'gnu/linux))

(cond (running-on-macos
       ;; Maximize frames on MacOS
       (add-to-list 'default-frame-alist '(fullscreen . fullboth                  ))

       ;; Extend `exec-path'
       (add-to-list 'exec-path           "/usr/local/bin"                         )
       (add-to-list 'exec-path           (expand-file-name "bin"  vs-xdg-local-dir))
       (add-to-list 'exec-path           (expand-file-name ".bin" vs-user-home-dir))

       ;; Set proper certificate for 'gnutls' in MacOS
       (with-eval-after-load 'gnutls
         (add-to-list 'gnutls-trustfiles "/private/etc/ssl/cert.pem"))

       (setq mac-command-modifier             'meta
             mac-option-modifier              'alt
             ns-pop-up-frames                 nil))

      (running-on-linux
       (setq x-gtk-use-system-tooltips nil)))

(provide 'set-ostweaks)
;;; set-ostweaks.el ends here
