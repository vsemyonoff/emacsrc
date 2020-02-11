;;; use-flymd.el --- Sow on the fly markdown mode changes. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'flymd))
    (warn "===> Can't install 'flymd'")

  (add-hook 'markdown-mode-hook #'flymd-flyit)

  (with-eval-after-load 'flymd
    (defun vs:flymd/browser-function (url)
      (let ((process-environment (browse-url-process-environment)))
        (apply 'start-process
               (concat "browser " url) nil
               "browser"
               (list "--new-window" url)
               )
        )
      )

    (setq flymd-browser-open-function 'vs:flymd/browser-function
          flymd-output-directory      (vs:emacs/runtime "flymd")
          )
    )
  )

(provide 'use-flymd)
;;; use-flymd.el ends here
