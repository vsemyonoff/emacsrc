;;; set-fringe.el ---  fringe settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(setq-default fringe-indicator-alist (delq
                                      (assq 'continuation fringe-indicator-alist)
                                      fringe-indicator-alist
                                      )
              fringes-outside-margins    t
              indicate-buffer-boundaries t
              indicate-empty-lines       t
              )

(defun vs|emacs/fringe-enable ()
  "Enable fringe, set sizes."
  (when (display-graphic-p)
    (fringe-mode '(nil . 0))
    )
  )

(add-hook 'vs-emacs-config-gui-hook #'vs|emacs/fringe-enable)

(provide 'set-fringe)
;;; set-fringe.el ends here
