;;; use-ivy.el ---  helper framework. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package hydra)

(use-package ivy :delight
  :config
  (progn
    (setq ivy-count-format            "[%d/%d] "
          ivy-extra-directories       nil
          ivy-fixed-height-minibuffer t
          ivy-format-function         'vs:ivy:format
          ivy-re-builders-alist       '((t . ivy--regex-ignore-order))
          ivy-use-selectable-prompt   t
          ivy-use-virtual-buffers     t
          ivy-virtual-abbreviate      'full)

    (defun vs:ivy:format (cands)
      (ivy--format-function-generic
       (lambda (str)
         (concat " => " (ivy--add-face str 'ivy-current-match)))
       (lambda (str)
         (concat "    " str))
       cands
       "\n"))

    (defun vs:ivy:set-height ()
      (setq ivy-height `,(floor (frame-height) 3))))

  :hook ((vs-emacs-config             . ivy-mode         )
         (window-configuration-change . vs:ivy:set-height)))

(use-package ivy-hydra
  :after (hydra ivy))

(use-package swiper
  :after ivy
  :bind ("C-s" . swiper))

(use-package counsel :delight
  :hook (vs-emacs-config . counsel-mode))

(use-package counsel-projectile
  :after counsel
  :hook (vs-emacs-config . counsel-projectile-mode))

(provide 'use-ivy)
;;; use-ivy.el ends here
