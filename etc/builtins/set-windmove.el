;;; set-windmove.el ---  windows navigation settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(defun vs|emacs/quit-window-kills-buffer (&optional kill window)
  "When running `quit-window' always kill underlying buffer."
  (list (if (delq (or window (selected-window))
                  (get-buffer-window-list nil nil t))
            nil
          t)
        window))
(advice-add 'quit-window :filter-args 'vs|emacs/quit-window-kills-buffer)

(add-hook 'vs-emacs-config-hook
          (lambda () (windmove-default-keybindings 'meta)))

(provide 'set-windmove)
;;; set-windmove.el ends here
