;;; use-url.el ---  eww mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package url
  :config
  (setq browse-url-browser-function 'eww-browse-url
        url-configuration-directory (expand-file-name "url/" vs-emacs-cache-dir)))


(provide 'use-url)
;;; use-url.el ends here
