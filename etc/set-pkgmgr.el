;;; set-pkgmgr.el --- package manager settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'delight)
;; Config
(delight '((abbrev-mode           nil     abbrev    )
           (eldoc-mode            nil     eldoc     )
           (emacs-lisp-mode       "ELisp" :major    )
           (lisp-interaction-mode "IELisp":major    )
           (whitespace-mode       nil     whitespace)))

(provide 'set-pkgmgr)
;;; set-pkgmgr.el ends here
