(require 'xdg) ; requires emacs 26

;; Set '$XDG_DATA_HOME/emacs' as `user-emacs-directory'.
(setq user-emacs-directory (expand-file-name "emacs/" (file-name-as-directory (xdg-data-home))))

;; Always put the socket in the right place.
(setq server-socket-dir (expand-file-name "emacs/" (file-name-as-directory (xdg-runtime-dir))))
