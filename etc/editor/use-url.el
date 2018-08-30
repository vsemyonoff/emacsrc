;;; use-url.el ---  eww mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package url
  :config (setq browse-url-browser-function 'eww-browse-url
                url-configuration-directory (expand-file-name (convert-standard-filename "url/")
                                                              vs-emacs-cache-dir)))

(provide 'use-url)
;;; set-url.el ends here
