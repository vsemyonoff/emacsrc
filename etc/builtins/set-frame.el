;;; set-frame.el ---  various frame settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-functions)

(with-eval-after-load 'frame
  (setq window-divider-default-bottom-width 0
        window-divider-default-places       t
        window-divider-default-right-width  1)

  (defun vs|emacs/make-frame-filter (&optional parameters)
    "Apply `initial-frame-alist' to `make-frame' function in `daemon' mode
while creating first visible GUI frame."
    (if (and (daemonp) (= (vs|emacs/gui-frames-count) 0))
        (list (append initial-frame-alist (car parameters)))
      parameters
      )
    )
  (advice-add 'make-frame :filter-args 'vs|emacs/make-frame-filter)

  (add-hook 'vs-emacs-config-gui-hook #'window-divider-mode)
  )

(provide 'set-frame)
;;; set-frame.el ends here
