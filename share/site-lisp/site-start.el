(require 'xdg) ; requires emacs 26

;; Load '$XDG_DATA_HOME/emacs/init.el'.
(let ((user-init-file-xdg (expand-file-name "emacs/init.el" (xdg-config-home))))
  (when (file-exists-p user-init-file-xdg)
    (load user-init-file-xdg)))
