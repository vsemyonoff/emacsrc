;;; set-tramp.el ---  tramp mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(with-eval-after-load 'tramp
  (warn "===> [TODO]: setup tramp to work with remote projects")
  (setq remote-file-name-inhibit-cache nil
        tramp-default-method           "sshx"
        tramp-persistency-file-name    (vs:emacs/cache "tramp.el")
        tramp-verbose                  1
        vc-ignore-dir-regexp           (format "%s\\|%s"
                                               vc-ignore-dir-regexp
                                               tramp-file-name-regexp)
        )
  )

(provide 'set-tramp)
;;; set-tramp.el ends here
