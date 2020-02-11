;;; set-pkgmgr.el --- package manager settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)

;; Set proper TLS certificate for MacOS
(when (eq system-type 'darwin)
  (with-eval-after-load 'gnutls
    (add-to-list 'gnutls-trustfiles "/private/etc/ssl/cert.pem")
    )
  )

(setq-default straight-base-dir vs-emacs-cache-dir
              straight-repository-branch "develop"
              straight-vc-git-default-clone-depth 1)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" straight-base-dir))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(if (not (straight-use-package 'use-package))
    (error "===> Can't install 'use-package'")

  (setq-default straight-use-package-by-default t
                use-package-always-defer        t)

  (defmacro use-feature (name &rest args)
    "Like `use-package', but with `straight-use-package-by-default' disabled."
    (declare (indent defun))
    `(use-package ,name
       :straight (:type built-in)
       ,@args))

  (defun vs:use-package/before-if (name _keyword pred rest state)
    (unless pred (warn "===> [%s] package predicate failed, skipping..." name)))

  (advice-add 'use-package-handler/: :before 'vs:use-package/before-if))

(provide 'set-pkgmgr)
;;; set-pkgmgr.el ends here
