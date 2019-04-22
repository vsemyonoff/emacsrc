;;; use-ivy.el ---  helper framework. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)
(require 'straight)
(require 'delight)

(if (not (straight-use-package 'hydra))
    (warn "===> Can't install 'hydra'")
  )

(if (not (straight-use-package 'counsel))
    (warn "==> Can't install 'counsel'")
  ;; Triggers
  (add-hook 'vs-emacs-config-hook #'ivy-mode)

  ;; Keybindings
  (define-key (current-global-map) (kbd "C-r") #'swiper)
  (define-key (current-global-map) (kbd "C-s") #'swiper)

  ;; Delight
  (delight '((counsel-mode nil counsel)
             (ivy-mode     nil ivy    )))

  ;; Config
  (with-eval-after-load 'ivy
    (warn "===> [TODO]: ivy modes for gitlab, passwords")

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
       "\n")
      )

    (add-hook 'ivy-mode-hook #'counsel-mode)
    )

  (if (not (straight-use-package 'ivy-hydra))
      (warn "===> Can't install 'ivy-hydra'")
    )

  (with-eval-after-load 'projectile
    (if (not (straight-use-package 'counsel-projectile))
        (warn "===> Can't install 'counsel-projectile'")

      (add-hook 'counsel-mode-hook #'counsel-projectile-mode)
      )
    )

  (if (not (straight-use-package 'ivy-rich))
      (warn "===> Can't install 'ivy-rich'")

    ;; Triggers
    (add-hook 'counsel-mode-hook #'ivy-rich-mode)

    ;; Config
    (with-eval-after-load 'ivy-rich
      (warn "===> [TODO]: setup ivy-rich kill buffer")
      (setq ivy-rich-path-style 'full)
      )
    )
  )
(provide 'use-ivy)
;;; use-ivy.el ends here
