;;; set-minibuffer.el ---  minibuffer settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(setq enable-recursive-minibuffers nil
      minibuffer-prompt-properties '(cursor-intangible t
                                     face minibuffer-prompt
                                     point-entered minibuffer-avoid-prompt
                                     read-only t
                                     )
      )

(add-hook 'minibuffer-exit-hook  #'vs|emacs/disable-optimizations)
(add-hook 'minibuffer-setup-hook #'vs|emacs/enable-optimizations)

(with-eval-after-load 'fringe
  (warn "===> [TODO]: show unsaved changes in fringe")
  (defun vs|emacs/fringe-minibuffer-disable ()
    "Disable fringes in `minibuffer' windows."
    (set-window-fringes (minibuffer-window) 0 0 nil)
    )
  (add-hook 'minibuffer-setup-hook #'vs|emacs/fringe-minibuffer-disable)
  )

(provide 'set-minibuffer)
;;; set-minibuffer.el ends here
