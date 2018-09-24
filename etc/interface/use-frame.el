;;; use-frame.el ---  various frame settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package frame :ensure nil
  :config
  (defun vs|emacs/make-frame-filter (&optional parameters)
    "Apply `initial-frame-alist' to `make-frame' function in `daemon' mode
while creating first visible GUI frame."
    (if (and (daemonp) (= (vs|emacs/gui-frames-count) 0))
        (list (append initial-frame-alist (car parameters)))
      parameters))
  (advice-add 'make-frame :filter-args 'vs|emacs/make-frame-filter)

  (setq window-divider-default-bottom-width 0
        window-divider-default-places       t
        window-divider-default-right-width  1)

  :hook (vs-emacs-config-gui . window-divider-mode))


(provide 'use-frame)
;;; use-frame.el ends here
