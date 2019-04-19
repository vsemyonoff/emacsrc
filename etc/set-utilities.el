;;; set-utilities.el --- utilities setup. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-functions)

(warn "===> [TODO]: mail setup")
(warn "===> [TODO]: org-mode setup")

(vs|emacs/require-dir (expand-file-name "utilities"
                                        vs-emacs-config-dir))

(provide 'set-utilities)
;;; set-utilities.el ends here
