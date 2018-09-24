;;; use-ivy.el ---  helper framework. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package hydra)


(use-package ivy :delight
  :config
  (setq ivy-count-format            "[%d/%d]: "
        ivy-extra-directories       nil
        ivy-format-function         'vs|ivy/custom-format
        ivy-ignore-buffers          '("\\`\\( \\|\\*lsp\\|treemacs\\)")
        ivy-re-builders-alist       '((t . ivy--regex-ignore-order))
        ivy-use-selectable-prompt   t
        ivy-use-virtual-buffers     t
        ivy-virtual-abbreviate      'full)

  (defun vs|ivy/custom-format (cands)
    "Set custom `ivy' format."
    (ivy--format-function-generic
     (lambda (str)
       (concat " => " (ivy--add-face str 'ivy-current-match)))
     (lambda (str)
       (concat "    " str))
     cands
     "\n"))

  (defun vs|ivy/update-window-height ()
    "Set `ivy' window height to 25% from current frame height."
    (setq ivy-height `,(floor (frame-height) 4)))

  :hook
  ((vs-emacs-config             . ivy-mode                   )
   (window-configuration-change . vs|ivy/update-window-height))

  :init (warn "===> TODO: ivy modes for gitlab, passwords"))


(use-package ivy-hydra
  :after (hydra ivy))


(use-package swiper
  :after (ivy)
  :general
  ("C-r" 'swiper
   "C-s" 'swiper))


(use-package counsel :delight
  :after (ivy)
  :hook (ivy-mode . counsel-mode))


(use-package counsel-projectile
  :after (counsel projectile)
  :hook (counsel-mode . counsel-projectile-mode))


(use-package ivy-rich
  :after (counsel)
  :config (setq ivy-rich-path-style 'full)
  :hook (counsel-mode . ivy-rich-mode)
  :init (warn "===> TODO: setup ivy-rich kill buffer"))


(provide 'use-ivy)
;;; use-ivy.el ends here
