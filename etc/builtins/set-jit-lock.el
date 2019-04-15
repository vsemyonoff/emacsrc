;;; use-jit-lock.el ---  lazy lock mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(setq-default font-lock-multiline t)
(setq font-lock-support-mode      'jit-lock-mode)

;; Config
(with-eval-after-load 'jit-lock
  (setq jit-lock-defer-time         nil
        jit-lock-stealth-nice       0.1
        jit-lock-stealth-time       0.2
        jit-lock-stealth-verbose    nil))

(provide 'set-jit-lock)
;;; set-jit-lock.el ends here
