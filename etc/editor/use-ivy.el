;;; use-ivy.el ---  helper framework. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package ivy
  :config
  (setq ivy-count-format        "%d/%d ==> "
        ;;ivy-extra-directories   nil
        ivy-re-builders-alist   '((t . ivy--regex-ignore-order))
        ivy-use-virtual-buffers t
        ivy-virtual-abbreviate  'full)

  ;; Set ivy's height to 30% from frame height
  (defun vs|set-ivy-height-alist (&optional _)
    (setq ivy-height-alist `((t . ,(floor (frame-height) 3)))))

  ;;(add-hook 'vs-config-ui-hook            #'vs|set-ivy-height-alist)
  (add-hook 'window-size-change-functions #'vs|set-ivy-height-alist)


  :delight (ivy-mode " Ⓘ")
  :hook ((vs-config . ivy-mode))
  )

(use-package ivy-rich
  :after ivy
  :config (setq ivy-rich-path-style 'abbrev
                ivy-rich-switch-buffer-align-virtual-buffer t)
  :hook (vs-config . ivy-rich-mode)
  )

(use-package counsel)

(use-package counsel-projectile
  :after counsel
  :hook (config . counsel-projectile-mode)
  )

(provide 'use-ivy)
;;; use-ivy.el ends here
