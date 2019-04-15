;;; set-mule.el --- Multilignaual environment settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(with-eval-after-load 'mule
  (prefer-coding-system        'utf-8)
  (set-keyboard-coding-system  'utf-8)
  (set-selection-coding-system 'utf-8)
  (set-terminal-coding-system  'utf-8)

  ;; Add extra keywords to `password-word-equivalents'
  (mapc (lambda (word) (add-to-list 'password-word-equivalents word))
        '("code" "key" "token")))

(provide 'set-mule)
;;; set-mule.el ends here
