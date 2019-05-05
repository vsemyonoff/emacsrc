;;; set-browse-url.el ---  browse-url, mm-decode, eww and shr settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(with-eval-after-load 'browse-url
  (setq browse-url-browser-function 'eww-browse-url)
  )

(with-eval-after-load 'mm-decode
  (setq mm-text-html-renderer       'shr
        )
  )

(with-eval-after-load 'shr
  (setq shr-use-colors               nil
        shr-use-fonts                t
        )
  )

(with-eval-after-load 'url
  (setq url-configuration-directory (vs|emacs/cache "url/"))
  (unless (file-exists-p url-configuration-directory)
    (make-directory url-configuration-directory t)
    )
  )

(provide 'set-browse-url)
;;; set-browse-url.el ends here
