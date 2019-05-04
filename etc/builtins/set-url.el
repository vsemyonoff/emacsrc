;;; set-url.el ---  eww mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(setq browse-url-browser-function 'browse-url-default-browser
      ;; '(
      ;;   ("." . browse-url-default-browser)
      ;;   )
      ;; browse-url-chrome-program ""
      )

;; Config
(with-eval-after-load 'url
  (setq url-configuration-directory (vs|emacs/cache "url/"))
  (unless (file-exists-p url-configuration-directory)
    (make-directory url-configuration-directory t)
    )
  )

(provide 'set-url)
;;; set-url.el ends here
