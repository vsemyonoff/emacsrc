;;; use-hideshow.el --- Hide/Show functions. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package hideshow
  ;;:ensure nil
  :straight (:type built-in)
  :bind (:map c-mode-base-map
              ("C-c <right>" . hs-show-block)
              ("C-c <left>"  . hs-hide-block)
              ("C-c <up>"    . hs-hide-all  )
              ("C-c <down>"  . hs-show-all  ))

  :hook (c-mode-common . hs-minor-mode))

(provide 'use-hideshow)
;;; use-hideshow.el ends here
