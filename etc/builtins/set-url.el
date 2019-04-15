;;; set-url.el ---  eww mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)

(setq browse-url-browser-function 'eww-browse-url)

;; Config
(with-eval-after-load 'url
  (setq url-configuration-directory (expand-file-name "url/"
                                                      vs-emacs-cache-dir))
  (unless (file-exists-p url-configuration-directory)
    (make-directory url-configuration-directory t)))

(provide 'set-url)
;;; set-url.el ends here
