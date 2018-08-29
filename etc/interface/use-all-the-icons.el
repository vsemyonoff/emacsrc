;;; use-all-the-icons.el ---  pretty icons package. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package all-the-icons
  :commands (all-the-icons-octicon all-the-icons-faicon all-the-icons-fileicon
             all-the-icons-wicon all-the-icons-material all-the-icons-alltheicon
             all-the-icons-install-fonts)
  ;;:config (setq inhibit-compacting-font-caches t)
  ;; :init
  ;; (defun vs|disable-all-the-icons-in-tty (orig-fn &rest args)
  ;;   (when (or (not (daemonp)) (display-graphic-p))
  ;;     (apply orig-fn args)))

  ;; (dolist (fn '(all-the-icons-octicon
  ;;               all-the-icons-material
  ;;               all-the-icons-faicon
  ;;               all-the-icons-fileicon
  ;;               all-the-icons-wicon
  ;;               all-the-icons-alltheicon))
  ;;   (advice-add fn :around #'vs|disable-all-the-icons-in-tty))
  )

(provide 'use-all-the-icons)
;;; use-all-the-icons.el ends here
