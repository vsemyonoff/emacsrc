;;; use-ivy.el ---  helper framework. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package ivy :delight
  :config
  (progn
    (setq ivy-count-format        "%d/%d ==> "
          ivy-extra-directories   nil
          ivy-re-builders-alist   '((t . ivy--regex-ignore-order))
          ivy-use-virtual-buffers t
          ivy-virtual-abbreviate  'full)

    (defun vs|set-ivy-height (&optional frame)
      (setq ivy-height-alist `((t . ,(floor (frame-height frame) 3)))))
    (add-hook 'window-size-change-functions #'vs|set-ivy-height))

  :hook (vs-emacs-config . ivy-mode))

(use-package counsel :delight
  :hook (vs-emacs-config . counsel-mode))

(use-package counsel-projectile
  :after counsel
  :hook (vs-emacs-config . counsel-projectile-mode))

(provide 'use-ivy)
;;; use-ivy.el ends here
