;;; use-jit-lock.el ---  lazy lock mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package jit-lock :ensure nil
  :config
  (progn
    (setq-default font-lock-multiline t)
    (setq font-lock-support-mode      'jit-lock-mode
          jit-lock-defer-time         nil
          jit-lock-stealth-nice       0.1
          jit-lock-stealth-time       0.2
          jit-lock-stealth-verbose    nil)))

(provide 'use-jit-lock)
;;; use-jit-lock.el ends here
