;;; use-ivy.el ---  helper framework. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package ivy :delight
  :config
  (progn
    (setq ivy-count-format        "[%d/%d] "
          ivy-extra-directories   nil
          ivy-format-function     'vs//ivy-format-function
          ivy-re-builders-alist   '((t . ivy--regex-ignore-order))
          ivy-use-virtual-buffers t
          ivy-virtual-abbreviate  'full)

    (defun vs//ivy-format-function (cands)
      (ivy--format-function-generic
       (lambda (str)
         (concat " => " (ivy--add-face str 'ivy-current-match)))
       (lambda (str)
         (concat "    " str))
       cands
       "\n"))

    (defun vs|set-ivy-height ()
      (setq ivy-height `,(floor (frame-height) 3))))

  :hook ((vs-emacs-config             . ivy-mode         )
         (window-configuration-change . vs|set-ivy-height)))

(use-package counsel :delight
  :hook (vs-emacs-config . counsel-mode))

(use-package counsel-projectile
  :after counsel
  :hook (vs-emacs-config . counsel-projectile-mode))

(provide 'use-ivy)
;;; use-ivy.el ends here
