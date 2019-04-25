;;; set-bindings.el ---  key bindings settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;;     [TODO]: refactoring
;;; Code:
(define-key (current-global-map) [remap move-beginning-of-line] #'vs|emacs|smart-move-beginning-of-line)
(define-key (current-global-map) (kbd "A-<backspace>")          #'vs|emacs|backward-delete-word)
                                        ;"<A-left>"                     'left-word
                                        ;"<A-right>"                    'right-word
                                        ;"<C-S-backspace>"              nil
                                        ;"<C-backspace>"                nil
                                        ;"<C-left>"                     'move-beginning-of-line
                                        ;"<C-right>"                    'move-end-of-line
                                        ;"<M-backspace>"                'vs|emacs|backward-delete-line
                                        ;"<M-f4>"                       'kill-this-buffer)

(provide 'set-bindings)
;;; set-bindings.el ends here
