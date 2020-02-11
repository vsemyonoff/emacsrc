;;; set-frame.el ---  various frame settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(with-eval-after-load 'frame
  (setq window-divider-default-bottom-width 0
        window-divider-default-places       t
        window-divider-default-right-width  1)

  ;; Unbind `suspend-frame'
  (define-key global-map (kbd "C-x C-z") nil)
  (define-key global-map (kbd "C-z"    ) nil)

  (defun vs:emacs/make-frame-filter (&optional parameters)
    "Apply `initial-frame-alist' to `make-frame' function in `daemon' mode
while creating first visible GUI frame."
    (if (and (daemonp) (= (vs:emacs/gui-frames-count) 0))
        (list (append initial-frame-alist (car parameters)))
      parameters
      )
    )
  (advice-add 'make-frame :filter-args 'vs:emacs/make-frame-filter)

  (add-hook 'vs-emacs-config-gui-hook #'window-divider-mode)
  )

(provide 'set-frame)
;;; set-frame.el ends here
