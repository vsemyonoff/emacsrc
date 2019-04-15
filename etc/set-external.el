;;; set-external.el --- external packages settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-functions)

(vs|emacs/require-dir (expand-file-name "external"
                                        vs-emacs-config-dir))

(provide 'set-external)
;;; set-external.el ends here
