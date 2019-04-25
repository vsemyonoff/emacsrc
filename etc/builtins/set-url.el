;;; set-url.el ---  eww mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(setq browse-url-browser-function 'eww-browse-url)

;; Config
(with-eval-after-load 'url
  (setq url-configuration-directory (vs|emacs/cache "url/"))
  (unless (file-exists-p url-configuration-directory)
    (make-directory url-configuration-directory t)
    )
  )

(provide 'set-url)
;;; set-url.el ends here
