;;; use-jit-lock.el ---  lazy lock mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package jit-lock :ensure nil
  :config (setq jit-lock-defer-time      nil
                jit-lock-stealth-nice    0.1
                jit-lock-stealth-time    0.2
                jit-lock-stealth-verbose nil)
  :hook (change-major-mode . (lambda () (jit-lock-mode t))))

(provide 'use-jit-lock)
;;; use-jit-lock.el ends here
