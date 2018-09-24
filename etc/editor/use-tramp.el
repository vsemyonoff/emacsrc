;;; use-tramp.el ---  tramp mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package tramp
  :config
  (warn "===> TODO: setup tramp to work with remote projects")

  (setq remote-file-name-inhibit-cache nil
        tramp-default-method           "ssh"
        tramp-persistency-file-name    (expand-file-name "tramp.el" vs-emacs-cache-dir)
        tramp-verbose                  1
        vc-ignore-dir-regexp           (format "%s\\|%s" vc-ignore-dir-regexp tramp-file-name-regexp))

  (defun vs|tramp/read-password-filter (orig-fn &rest args)
    "Don't look into .authinfo for local sudo TRAMP buffers."
    (let ((auth-sources (if (equal tramp-current-method "sudo") nil auth-sources)))
      (apply orig-fn args)))
  (advice-add 'tramp-read-passwd :around 'vs|tramp/read-password-filter)

  :init
  (mapc (lambda (word)
          (add-to-list 'password-word-equivalents word))
        '("code" "key" "token")))


(provide 'use-tramp)
;;; use-tramp.el ends here
