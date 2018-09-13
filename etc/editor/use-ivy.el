;;; use-ivy.el ---  helper framework. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package hydra)


(use-package ivy :delight
  :config
  (progn
    (setq ivy-count-format            "[%d/%d] "
          ivy-extra-directories       nil
          ivy-format-function         'vs|ivy/custom-format
          ivy-ignore-buffers          '("\\`\\( \\|\\*lsp\\|treemacs\\)")
          ivy-re-builders-alist       '((t . ivy--regex-ignore-order))
          ivy-use-selectable-prompt   t
          ivy-use-virtual-buffers     t
          ivy-virtual-abbreviate      'full)

    (defun vs|ivy/custom-format (cands)
      (ivy--format-function-generic
       (lambda (str)
         (concat " => " (ivy--add-face str 'ivy-current-match)))
       (lambda (str)
         (concat "    " str))
       cands
       "\n"))

    (defun vs|ivy/update-window-height ()
      (setq ivy-height `,(floor (frame-height) 3))))

  :hook
  ((vs-emacs-config             . ivy-mode         )
   (window-configuration-change . vs|ivy/update-window-height)))


(use-package ivy-hydra
  :after (hydra ivy))


(use-package swiper
  :general ("C-s" 'swiper))


(use-package counsel :delight
  :hook (vs-emacs-config . counsel-mode))


(use-package counsel-projectile
  :hook (vs-emacs-config . counsel-projectile-mode))


(provide 'use-ivy)
;;; use-ivy.el ends here
