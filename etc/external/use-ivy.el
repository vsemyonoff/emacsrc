;;; use-ivy.el ---  helper framework. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package ivy
  :hook (vs-emacs-config . ivy-mode)
  ;; :bind
  ;; (("C-j" . ivy-immediate-done)
  ;; ("RET"  . ivy-alt-done))
  :config
  (setq ivy-count-format            "[%d/%d]: "
        ivy-extra-directories       nil
        ivy-ignore-buffers          '("\\`\\( \\|\\*\\)")
        ivy-re-builders-alist       '((t . ivy--regex-ignore-order))
        ivy-use-selectable-prompt   t
        ivy-use-virtual-buffers     t
        ivy-virtual-abbreviate      'abbreviate)

  (defun vs:ivy/custom-format (cands)
    "Set custom `ivy' format."
    (ivy--format-function-generic
     (lambda (str)
       (concat "=> " (ivy--add-face str 'ivy-current-match)))
     (lambda (str)
       (concat "   " str))
     cands
     "\n"))

  (setf (alist-get t ivy-format-functions-alist) #'vs:ivy/custom-format))

(use-package counsel
  :after ivy
  :hook (ivy-mode . counsel-mode))

(use-package counsel-projectile
  :after (counsel projectile)
  :hook (counsel-mode . counsel-projectile-mode)
  )

(use-package swiper
  :after ivy
  :bind
  (("C-r" . swiper)
   ("C-s" . swiper)))

(use-package ivy-hydra
  :after ivy)

(use-package ivy-rich
  :after counsel
  :hook (counsel-mode . ivy-rich-mode)
  :config
  (setq ivy-rich-path-style 'abbreviate
        ivy-rich-switch-buffer-align-virtual-buffer t)
  )

(provide 'use-ivy)
;;; use-ivy.el ends here
